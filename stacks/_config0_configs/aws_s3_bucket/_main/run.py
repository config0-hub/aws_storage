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

from config0_publisher.terraform import TFConstructor


def run(stackargs):

    # instantiate authoring stack
    stack = newStack(stackargs)

    # Add default variables
    stack.parse.add_required(key="bucket",
                             tags="resource,db,tfvar",
                             types="str")

    stack.parse.add_required(key="acl",
                             default="_random",
                             tags="tfvar",
                             types="str")

    stack.parse.add_optional(key="versioning",
                             tags="resource,tfvar",
                             default=None,
                             types="bool")

    stack.parse.add_optional(key="force_destroy",
                             tags="resource,tfvar",
                             default=None,
                             types="bool")

    stack.parse.add_optional(key="enable_lifecycle",
                             tags="resource,tfvar",
                             default=None,
                             types="bool")

    stack.parse.add_optional(key="noncurrent_version_expiration",
                             tags="resource,tfvar",
                             default=None,
                             types="bool")

    stack.parse.add_optional(key="expire_days",
                             tags="resource,db,tfvar",
                             types="int")

    stack.parse.add_optional(key="aws_default_region",
                             default="eu-west-1",
                             tags="tfvar,db,resource,tf_exec_env",
                             types="str")

    # add execgroup
    stack.add_execgroup("config0-publish:::aws_storage::buckets",
                        "tf_execgroup")

    # Add substack
    stack.add_substack("config0-publish:::tf_executor")

    # initialize Variables in stack
    stack.init_variables()
    stack.init_execgroups()
    stack.init_substacks()

    # use the terraform constructor (helper)
    tf = TFConstructor(stack=stack,
                       execgroup_name=stack.tf_execgroup.name,
                       provider="aws",
                       resource_name=stack.bucket,
                       resource_type="cloud_storage")

    tf.include(values={
        "aws_default_region": stack.aws_default_region,
        "bucket": stack.bucket,
        "s3_bucket": stack.bucket
    })

    tf.include(maps={"id": "arn"})
    tf.output(keys=["arn"])

    # finalize the tf_executor
    stack.tf_executor.insert(display=True,
                             **tf.get())

    return stack.get_results()