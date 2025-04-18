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

    # Instantiate authoring stack
    stack = newStack(stackargs)

    # Add default variables
    stack.parse.add_required(key="ssm_value",
                             tags="tfvar",
                             types="str")

    stack.parse.add_required(key="ssm_key",
                             default="_random",
                             tags="tfvar",
                             types="str")

    stack.parse.add_optional(key="ssm_type",
                             default="SecureString",
                             tags="tfvar",
                             types="str")

    stack.parse.add_optional(key="ssm_description",
                             tags="tfvar",
                             types="str")

    stack.parse.add_optional(key="aws_default_region",
                             default="eu-west-1",
                             tags="tfvar,db,resource,tf_exec_env",
                             types="str")

    # Add execgroup
    stack.add_execgroup("config0-publish:::aws_storage::ssm_parameter_store",
                        "tf_execgroup")

    # Add substack
    stack.add_substack("config0-publish:::tf_executor")

    # Initialize Variables in stack
    stack.init_variables()
    stack.init_execgroups()
    stack.init_substacks()

    if not stack.get_attr("ssm_description"):
        stack.set_variable("ssm_description",
                           f"The ssm parameter for key = {stack.ssm_key}")

    # Use the terraform constructor (helper)
    tf = TFConstructor(stack=stack,
                       execgroup_name=stack.tf_execgroup.name,
                       provider="aws",
                       resource_name=stack.ssm_key,
                       resource_type="cloud_parameters")

    tf.include(values={
        "aws_default_region": stack.aws_default_region,
        "ssm_name": stack.ssm_key,
        "ssm_key": stack.ssm_key
    })

    tf.include(maps={"ssm_ref": "name"})
    tf.output(keys=["ssm_key"])

    # Finalize the tf_executor
    stack.tf_executor.insert(display=True,
                             **tf.get())

    return stack.get_results()