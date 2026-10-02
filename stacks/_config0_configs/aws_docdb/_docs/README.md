# AWS DocumentDB Stack

## Description
This stack creates an AWS DocumentDB 5.0 cluster with one instance, a dedicated subnet group, security groups, encryption at rest and TLS. The resource row carries `db_endpoint`, `db_port` and `db_name`, the target fields a `docdb_access` grant takes.

## Variables

### Required Variables

| Name | Description | Default |
|------|-------------|---------|
| subnet_ids | Subnet ID list | &nbsp; |
| sg_id | Security group ID | &nbsp; |
| docdb_name | Cluster identifier | &nbsp; |

### Optional Variables

| Name | Description | Default |
|------|-------------|---------|
| db_name | Database a grant targets | `_random` |
| engine_version | DocumentDB engine version; IAM authentication needs 5.0 | `5.0.0` |
| instance_class | Cluster instance type | `db.t3.medium` |
| port | Cluster port | `27017` |
| storage_encrypted | Enable storage encryption | `true` |
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
- [config0-hub:::aws_storage::docdb](http://config0.http.redirects.s3-website-us-east-1.amazonaws.com/assets/exec/groups/config0-hub/aws_storage/docdb/default)

### Scripts
- [config0-hub:::terraform::resource_wrapper](http://config0.http.redirects.s3-website-us-east-1.amazonaws.com/assets/scripts/config0-hub/terraform/resource_wrapper/default)

## License
<pre>
Copyright (C) 2025 Gary Leong <gary@config0.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3 of the License.
</pre>
