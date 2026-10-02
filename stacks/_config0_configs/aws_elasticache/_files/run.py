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

    # the replication group id; elasticache_access takes it as cache_name
    stack.parse.add_required(key="cache_name",
                             tags="resource,tf_exec_env,db,tfvar",
                             types="str")

    stack.parse.add_optional(key="engine",
                             default="redis",
                             tags="tfvar,db",
                             types="str",
                             choices=["redis", "valkey"])

    stack.parse.add_optional(key="engine_version",
                             default="7.1",
                             tags="tfvar",
                             types="str")

    stack.parse.add_optional(key="node_type",
                             default="cache.t4g.micro",
                             tags="tfvar",
                             types="str")

    stack.parse.add_optional(key="num_cache_clusters",
                             default=1,
                             tags="tfvar",
                             types="int")

    stack.parse.add_optional(key="port",
                             default="6379",
                             tags="tfvar",
                             types="int")

    stack.parse.add_optional(key="aws_default_region",
                             default="eu-west-1",
                             tags="tfvar,db,resource,tf_exec_env",
                             types="str")

    # add execgroup
    stack.add_execgroup("config0-hub:::aws_storage::elasticache",
                        "tf_execgroup")

    # add substack
    stack.add_substack("config0-hub:::config0_core::tf_executor")

    # initialize
    stack.init_variables()
    stack.init_execgroups()
    stack.init_substacks()

    stack.set_variable("security_group_ids",
                       stack.to_list(stack.sg_id),
                       tags="tfvar",
                       types="list")

    stack.set_variable("subnet_ids",
                       stack.to_list(stack.subnet_ids),
                       tags="tfvar",
                       types="list")

    # automatically name the subnet group and the user group
    stack.set_variable("cache_subnet_name",
                       f"{stack.cache_name}-subnet",
                       tags="tfvar",
                       types="str")

    stack.set_variable("user_group_id",
                       f"{stack.cache_name}-users",
                       tags="tfvar",
                       types="str")

    # the disabled default user still needs a password: 16-128 printable
    # characters (random_id is lowercase letters and digits only)
    stack.set_variable("default_user_password",
                       stack.random_id(size=32),
                       tags="tfvar",
                       types="str")

    stack.set_variable("timeout", 2700)

    # use the terraform constructor (helper)
    # the execgroup outputs cache_name, cache_type, user_group_id and engine,
    # the elasticache_access target fields, under those names
    tf = TFConstructor(stack=stack,
                       execgroup_name=stack.tf_execgroup.name,
                       provider="aws",
                       resource_name=stack.cache_name,
                       resource_type="elasticache")

    output_keys = [
        "cache_name",
        "cache_type",
        "user_group_id",
        "engine",
        "engine_version",
        "arn",
        "primary_endpoint_address",
        "port",
        "node_type"
    ]

    tf.output(keys=output_keys)

    # finalize the tf_executor
    stack.tf_executor.insert(display=True, **tf.get())

    return stack.get_results()
