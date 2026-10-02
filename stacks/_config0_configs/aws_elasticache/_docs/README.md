# AWS ElastiCache Stack

## Description
This stack creates an AWS ElastiCache replication group, Redis OSS 7.1 on one `cache.t4g.micro` node by default, cluster mode off, encrypted at rest and in transit, with a dedicated subnet group, security groups, and an RBAC user group `<cache_name>-users` whose only user is a disabled `default` user. The resource row carries `cache_name`, `cache_type` (`replication_group`), `user_group_id` and `engine`, the target fields and engine an `elasticache_access` grant takes.

## Variables

### Required Variables

| Name | Description | Default |
|------|-------------|---------|
| subnet_ids | Subnet ID list | &nbsp; |
| sg_id | Security group ID | &nbsp; |
| cache_name | Replication group id | &nbsp; |

### Optional Variables

| Name | Description | Default |
|------|-------------|---------|
| engine | Cache engine, `redis` or `valkey` | `redis` |
| engine_version | Engine version; IAM authentication needs Redis OSS 7+ or Valkey 7.2+ | `7.1` |
| node_type | Cache node type | `cache.t4g.micro` |
| num_cache_clusters | Number of cache nodes; more than 1 turns on automatic failover | `1` |
| port | Cache port | `6379` |
| aws_default_region | Default AWS region | `eu-west-1` |

When `engine` is `valkey`, set `engine_version` to 7.2 or later; the default `7.1` is Redis OSS only.

## Dependencies

### Substacks
- [config0-hub:::config0_core::tf_executor](http://config0.http.redirects.s3-website-us-east-1.amazonaws.com/assets/stacks/config0-hub/tf_executor/default)

### Execgroups
- [config0-hub:::aws_storage::elasticache](http://config0.http.redirects.s3-website-us-east-1.amazonaws.com/assets/exec/groups/config0-hub/aws_storage/elasticache/default)

### Scripts
- [config0-hub:::terraform::resource_wrapper](http://config0.http.redirects.s3-website-us-east-1.amazonaws.com/assets/scripts/config0-hub/terraform/resource_wrapper/default)

## License
<pre>
Copyright (C) 2025 Gary Leong <gary@config0.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3 of the License.
</pre>
