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

    # the cluster identifier; redshift_access takes it as redshift_cluster
    stack.parse.add_required(key="redshift_name",
                             tags="resource,tf_exec_env,db,tfvar",
                             types="str")

    stack.parse.add_optional(key="db_name",
                             default="_random",
                             tags="tfvar,db",
                             types="str")

    stack.parse.add_optional(key="node_type",
                             default="ra3.large",
                             tags="tfvar",
                             types="str")

    stack.parse.add_optional(key="number_of_nodes",
                             default=1,
                             tags="tfvar",
                             types="int")

    stack.parse.add_optional(key="port",
                             default="5439",
                             tags="tfvar",
                             types="int")

    stack.parse.add_optional(key="publicly_accessible",
                             default="false",
                             tags="tfvar",
                             types="bool")

    stack.parse.add_optional(key="encrypted",
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
    stack.add_execgroup("config0-hub:::aws_storage::redshift",
                        "tf_execgroup")

    # add substack
    stack.add_substack("config0-hub:::config0_core::tf_executor")

    # initialize
    stack.init_variables()
    stack.init_execgroups()
    stack.init_substacks()

    # automatically name the cluster subnet group
    stack.set_variable("security_group_ids",
                       stack.to_list(stack.sg_id),
                       tags="tfvar",
                       types="list")

    stack.set_variable("cluster_subnet_name",
                       f"{stack.redshift_name}-subnet",
                       tags="tfvar",
                       types="str")

    stack.set_variable("subnet_ids",
                       stack.to_list(stack.subnet_ids),
                       tags="tfvar",
                       types="list")

    # set username and password
    # ponytail: fixed prefixes meet Redshift's rules - the username starts with
    # a letter; the password needs an uppercase, a lowercase and a digit
    # (random_id is lowercase letters and digits only).
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
                           f"Rs0{stack.random_id(size=20)}",
                           tags="tfvar",
                           types="str")

    stack.set_variable("timeout", 2700)

    # use the terraform constructor (helper)
    tf = TFConstructor(stack=stack,
                       execgroup_name=stack.tf_execgroup.name,
                       provider="aws",
                       resource_name=stack.redshift_name,
                       resource_type="redshift")

    # redshift_cluster and db_name are the redshift_access target fields
    tf.include(values={"redshift_cluster": stack.redshift_name})

    output_keys = [
        "cluster_identifier",
        "arn",
        "endpoint",
        "port",
        "database_name",
        "node_type",
        "number_of_nodes",
        "publicly_accessible",
        "encrypted"
    ]

    tf.output(keys=output_keys)

    # finalize the tf_executor
    stack.tf_executor.insert(display=True, **tf.get())

    # put outputs onto the saas ui (optional)
    if stack.get_attr("publish_creds") or stack.get_attr("publish_to_saas"):
        _cred_outputs = {
            "redshift_root_user": stack.master_username,
            "redshift_root_password": stack.master_password
        }
        stack.output_to_ui(_cred_outputs)

    return stack.get_results()
