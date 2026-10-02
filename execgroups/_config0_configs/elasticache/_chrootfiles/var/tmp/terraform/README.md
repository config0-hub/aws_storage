# AWS ElastiCache Module

This OpenTofu module creates an AWS ElastiCache replication group (Redis OSS or Valkey, cluster mode off) with a dedicated subnet group and an RBAC user group.

## Features

- Creates a replication group, one `cache.t4g.micro` node by default
- Encrypted at rest and in transit
- Sets up a dedicated cache subnet group
- Attaches a user group whose only user is a disabled `default` user, so the cache has no open-access user; an access grant adds its IAM-authenticated user to the group

## Usage

```hcl
module "elasticache" {
  source = "./path/to/module"

  cache_name            = "my-cache"
  cache_subnet_name     = "my-cache-subnet"
  user_group_id         = "my-cache-users"
  default_user_password = "a-long-random-password"

  subnet_ids         = ["subnet-1234abcd", "subnet-5678efgh"]
  security_group_ids = ["sg-1234abcd"]

  cloud_tags = {
    Environment = "production"
  }
}
```

## Requirements

- OpenTofu >= 1.8.8
- AWS Provider

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws_default_region | The AWS region where resources will be created | `string` | `"us-east-1"` | no |
| cache_name | The replication group id of the ElastiCache cache | `string` | `"test-cache"` | no |
| cache_subnet_name | The name of the ElastiCache subnet group | `string` | `"cache_subnet_name"` | no |
| user_group_id | The id of the ElastiCache user group attached to the cache | `string` | `"test-cache-users"` | no |
| default_user_password | Password of the disabled default user in the user group | `string` | n/a | yes |
| engine | The cache engine, redis or valkey | `string` | `"redis"` | no |
| engine_version | The engine version; IAM authentication needs Redis OSS 7 or later, or Valkey 7.2 or later | `string` | `"7.1"` | no |
| node_type | The node type of the cache nodes | `string` | `"cache.t4g.micro"` | no |
| num_cache_clusters | The number of cache nodes; more than 1 turns on automatic failover | `number` | `1` | no |
| port | The port on which the cache accepts connections | `number` | `6379` | no |
| security_group_ids | List of VPC security group IDs to associate with the cache | `list(string)` | n/a | yes |
| subnet_ids | List of subnet IDs to include in the cache subnet group | `list(string)` | n/a | yes |
| cloud_tags | Additional tags as a map to apply to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| cache_name | The replication group id of the ElastiCache cache |
| cache_type | The ElastiCache cache type, always `replication_group` |
| user_group_id | The id of the ElastiCache user group attached to the cache |
| engine | The cache engine |
| engine_version | The running engine version of the cache |
| arn | The ARN of the ElastiCache replication group |
| primary_endpoint_address | The address of the primary node endpoint |
| reader_endpoint_address | The address of the reader endpoint |
| port | The port on which the cache accepts connections |
| node_type | The node type of the cache nodes |
| num_cache_clusters | The number of cache nodes in the replication group |
| subnet_group_name | The name of the ElastiCache subnet group |
| at_rest_encryption_enabled | Whether the cache is encrypted at rest |
| transit_encryption_enabled | Whether the cache is encrypted in transit |

## License

Copyright (C) 2025 Gary Leong <gary@config0.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3 of the License.
