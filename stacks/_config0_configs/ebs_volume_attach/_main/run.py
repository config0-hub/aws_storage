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


def _get_instance_id(stack):
    _lookup = {
        "must_exists": True,
        "must_be_one": True,
        "resource_type": "server",
        "hostname": stack.hostname,
        "region": stack.aws_default_region
    }

    return list(stack.get_resource(**_lookup))[0]["instance_id"]


def _get_volume_id(stack):
    _lookup = {
        "must_exists": True,
        "must_be_one": True,
        "name": stack.volume_name,
        "resource_type": "ebs_volume",
        "region": stack.aws_default_region
    }

    return list(stack.get_resource(**_lookup))[0]["volume_id"]


def run(stackargs):
    # instantiate authoring stack
    stack = newStack(stackargs)

    # Add default variables
    stack.parse.add_required(key="hostname",
                             tags="resource,db",
                             types="str")

    stack.parse.add_optional(key="volume_name",
                             tags="resource,db",
                             default=None,
                             types="str")

    stack.parse.add_optional(key="device_name",
                             tags="tfvars,db,resource",
                             default="/dev/xvdc",
                             types="str")

    stack.parse.add_optional(key="aws_default_region",
                             default="eu-west-1",
                             tags="tfvar,db,resource,tf_exec_env",
                             types="str")

    # Add execgroup
    stack.add_execgroup("config0-publish:::aws_storage::attach_volume_to_ec2",
                        "tf_execgroup")

    # Add substack
    stack.add_substack("config0-publish:::tf_executor")

    # Initialize
    stack.init_variables()
    stack.init_execgroups()
    stack.init_substacks()

    if not stack.get_attr("volume_name"):
        stack.set_variable("volume_name",
                           f"{stack.hostname}-data",
                           tags="resource")

    stack.set_variable("instance_id",
                       _get_instance_id(stack),
                       tags="resource,tfvar")

    stack.set_variable("volume_id",
                       _get_volume_id(stack),
                       tags="resource,tfvar")

    # use the terraform constructor (helper) but this is optional
    tf = TFConstructor(stack=stack,
                       execgroup_name=stack.tf_execgroup.name,
                       provider="aws",
                       resource_name=f"attachment_{stack.volume_name}",
                       resource_type="ebs_volume_attach")

    tf.include(values={
        "aws_default_region": stack.aws_default_region
    })

    # finalize the tf_executor
    stack.tf_executor.insert(display=True,
                             **tf.get())

    return stack.get_results()