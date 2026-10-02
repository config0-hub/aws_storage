# AWS Redshift Cluster Stack

## Description
This stack creates an AWS Redshift provisioned cluster, single-node `ra3.large` by default, encrypted and not publicly accessible, with a dedicated cluster subnet group and security groups. The resource row carries `redshift_cluster` and `db_name`, the target fields a `redshift_access` grant takes.

## Variables

### Required Variables

| Name | Description | Default |
|------|-------------|---------|
| subnet_ids | Subnet ID list | &nbsp; |
| sg_id | Security group ID | &nbsp; |
| redshift_name | Cluster identifier | &nbsp; |

### Optional Variables

| Name | Description | Default |
|------|-------------|---------|
| db_name | Name of the first database | `_random` |
| node_type | Cluster node type | `ra3.large` |
| number_of_nodes | Number of compute nodes; 1 is single-node | `1` |
| port | Cluster port | `5439` |
| publicly_accessible | Make cluster publicly accessible | `false` |
| encrypted | Encrypt the cluster at rest | `true` |
| skip_final_snapshot | Skip final snapshot on deletion | `true` |
| master_username | Cluster admin username | `None` |
| master_password | Cluster admin password | `None` |
| aws_default_region | Default AWS region | `eu-west-1` |
| publish_creds | Configuration for publish creds | `None` |
| publish_to_saas | Boolean to publish values to config0 SaaS UI | `None` |

## Dependencies

### Substacks
- [config0-hub:::config0_core::tf_executor](http://config0.http.redirects.s3-website-us-east-1.amazonaws.com/assets/stacks/config0-hub/tf_executor/default)

### Execgroups
- [config0-hub:::aws_storage::redshift](http://config0.http.redirects.s3-website-us-east-1.amazonaws.com/assets/exec/groups/config0-hub/aws_storage/redshift/default)

### Scripts
- [config0-hub:::terraform::resource_wrapper](http://config0.http.redirects.s3-website-us-east-1.amazonaws.com/assets/scripts/config0-hub/terraform/resource_wrapper/default)

## License
<pre>
Copyright (C) 2025 Gary Leong <gary@config0.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3 of the License.
</pre>
