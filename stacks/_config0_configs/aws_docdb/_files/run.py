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
    stack.parse.add_required(key="subnet_ids")

    stack.parse.add_required(key="sg_id",
                             types="str")

    # the cluster identifier
    stack.parse.add_required(key="docdb_name",
                             tags="resource,tf_exec_env,db,tfvar",
                             types="str")

    # the database a docdb_access grant targets; DocumentDB creates it on
    # first write, so the execgroup only outputs it
    stack.parse.add_optional(key="db_name",
                             default="_random",
                             tags="tfvar,db",
                             types="str")

    stack.parse.add_optional(key="engine_version",
                             default="5.0.0",
                             tags="tfvar",
                             types="str")

    stack.parse.add_optional(key="instance_class",
                             default="db.t3.medium",
                             tags="tfvar",
                             types="str")

    stack.parse.add_optional(key="port",
                             default="27017",
                             tags="tfvar",
                             types="int")

    stack.parse.add_optional(key="storage_encrypted",
                             default="true",
                             tags="tfvar",
                             types="bool")

    stack.parse.add_optional(key="skip_final_snapshot",
                             default="true",
                             tags="tfvar",
                             types="bool")

    stack.parse.add_optional(key="master_username",
                             default=None,
                             tags="tfvar",
                             types="str")

    stack.parse.add_optional(key="master_password",
                             default=None,
                             tags="tfvar",
                             types="str")

    stack.parse.add_optional(key="aws_default_region",
                             default="eu-west-1",
                             tags="tfvar,db,resource,tf_exec_env",
                             types="str")

    stack.parse.add_optional(key="publish_creds",
                             default=None,
                             types="bool")

    stack.parse.add_optional(key="publish_to_saas",
                             default=None,
                             types="bool")

    # add execgroup
    stack.add_execgroup("config0-hub:::aws_storage::docdb",
                        "tf_execgroup")

    # add substack
    stack.add_substack("config0-hub:::config0_core::tf_executor")

    # initialize
    stack.init_variables()
    stack.init_execgroups()
    stack.init_substacks()

    # automatically name the db_subnet_name
    stack.set_variable("security_group_ids",
                       stack.to_list(stack.sg_id),
                       tags="tfvar",
                       types="list")

    stack.set_variable("db_subnet_name",
                       f"{stack.docdb_name}-subnet",
                       tags="tfvar",
                       types="str")

    stack.set_variable("subnet_ids",
                       stack.to_list(stack.subnet_ids),
                       tags="tfvar",
                       types="list")

    # set username and password
    # ponytail: the "u" prefix makes the username start with a letter, as
    # DocumentDB requires; random_id passwords hold no / " @, which it bans.
    if not stack.get_attr("master_username") and stack.inputvars.get("DB_MASTER_USERNAME"):
        stack.set_variable("master_username",
                           stack.inputvars["DB_MASTER_USERNAME"],
                           tags="tfvar",
                           types="str")
    elif not stack.get_attr("master_username"):
        stack.set_variable("master_username",
                           f"u{stack.random_id(size=19)}",
                           tags="tfvar",
                           types="str")

    if not stack.get_attr("master_password") and stack.inputvars.get("DB_MASTER_PASSWORD"):
        stack.set_variable("master_password",
                           stack.inputvars["DB_MASTER_PASSWORD"],
                           tags="tfvar",
                           types="str")
    elif not stack.get_attr("master_password"):
        stack.set_variable("master_password",
                           stack.random_id(size=20),
                           tags="tfvar",
                           types="str")

    stack.set_variable("timeout", 2700)

    # use the terraform constructor (helper)
    tf = TFConstructor(stack=stack,
                       execgroup_name=stack.tf_execgroup.name,
                       provider="aws",
                       resource_name=stack.docdb_name,
                       resource_type="docdb")

    # the execgroup outputs db_endpoint, db_port and db_name, the docdb_access
    # target fields, under those names

    output_keys = [
        "cluster_identifier",
        "arn",
        "endpoint",
        "reader_endpoint",
        "port",
        "master_username",
        "engine_version",
        "instance_class",
        "storage_encrypted"
    ]

    tf.output(keys=output_keys)

    # finalize the tf_executor
    stack.tf_executor.insert(display=True, **tf.get())

    # put outputs onto the saas ui (optional)
    if stack.get_attr("publish_creds") or stack.get_attr("publish_to_saas"):
        _cred_outputs = {
            "docdb_root_user": stack.master_username,
            "docdb_root_password": stack.master_password
        }
        stack.output_to_ui(_cred_outputs)

    return stack.get_results()
