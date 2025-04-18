"""
# Copyright (C) 2025 Gary Leong <gary@config0.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
"""

import os
import boto3
from config0_publisher.terraform import TFConstructor


def get_ecr_repo(stack):

    # try to retrieve assume creds for users if needed
    if "OVERIDE_AWS_CREDS" in os.environ:
        inputargs = stack.b64_decode(os.environ["OVERIDE_AWS_CREDS"])
        inputargs["region_name"] = stack.aws_default_region
        ecr_client = boto3.client('ecr', **inputargs)
    else:
        ecr_client = boto3.client('ecr', region_name=stack.aws_default_region)

    try:
        response = ecr_client.describe_repositories(repositoryNames=[stack.ecr_repo])
    except ecr_client.exceptions.RepositoryNotFoundException:
        return

    if 'repositories' not in response:
        return

    if not response.get('repositories'):
        return

    repository = response['repositories'][0]

    return {
        'name': stack.ecr_repo,
        'repository_uri': repository['repositoryUri'],
        'region': repository['repositoryArn'].split(":")[3],
        'arn': repository['repositoryArn']
    }


def run(stackargs):

    # instantiate authoring stack
    stack = newStack(stackargs)

    # Add default variables
    stack.parse.add_required(key="ecr_repo",
                             tags="resource,db,tfvar",
                             types="str")

    stack.parse.add_optional(key="aws_default_region",
                             default="eu-west-1",
                             tags="tfvar,db,resource,tf_exec_env",
                             types="str")

    # Add execgroup
    stack.add_execgroup("config0-publish:::aws_storage::ecr_repo",
                        "tf_execgroup")

    # Add substack
    stack.add_substack("config0-publish:::tf_executor")

    # Initialize Variables in stack
    stack.init_variables()
    stack.init_execgroups()
    stack.init_substacks()

    # Check if ECR repo exists and is in Config0 db
    _repo = stack.check_resource(
            name=stack.ecr_repo,
            resource_type="ecr_repo",
            provider="aws"
    )

    if _repo:
        msg = f'ECR repo name {stack.ecr_repo} exists - creation not needed'
        stack.logger.debug(msg)
        cmd = "sleep 1"
        stack.add_external_cmd(cmd=cmd,
                               order_type="report::shellout",
                               human_description=msg,
                               display=True,
                               role="external/cli/execute")
        return stack.get_results()

    # Check if ECR repo exists in AWS but is not in Config0 db
    values = get_ecr_repo(stack)

    if values:
        inputargs = {
            "cluster": stack.cluster,
            "instance": stack.instance,
            "schedule_id": stack.schedule_id
        }

        values.update(inputargs)
        values.update({
                "provider": "aws",
                "source_method": "manual",
                "resource_type": "ecr_repo",
                })

        _id = stack.get_hash_object(values)
        values["_id"] = _id
        values["id"] = _id

        inputargs["values"] = values
        human_description = f'Adding resource_type "{values["resource_type"]}" id "{_id}"'
        inputargs["human_description"] = human_description

        stack.add_resource(**inputargs)

        return stack.get_results()

    # Create ECR repo from scratch
    tf = TFConstructor(stack=stack,
                       execgroup_name=stack.tf_execgroup.name,
                       provider="aws",
                       resource_name=stack.ecr_repo,
                       resource_type="ecr_repo")

    tf.include(values={
        "aws_default_region": stack.aws_default_region,
        "ecr_repo": stack.ecr_repo,
    })

    tf.include(maps={"repository_uri": "repository_url"})
    tf.output(keys=["arn", "repository_uri"])

    # Finalize the tf_executor
    stack.tf_executor.insert(display=True,
                             **tf.get())

    return stack.get_results()