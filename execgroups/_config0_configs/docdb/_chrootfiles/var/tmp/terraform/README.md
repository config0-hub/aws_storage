# AWS DocumentDB Module

This OpenTofu module creates an AWS DocumentDB cluster with one instance and a dedicated subnet group.

## Features

- Creates an encrypted DocumentDB 5.0 cluster with one `db.t3.medium` instance
- Sets up a dedicated subnet group for the cluster
- TLS on: the cluster uses the engine's default parameter group, which enables tls
- No final snapshot on deletion

## Usage

```hcl
module "docdb" {
  source = "./path/to/module"

  docdb_name      = "my-docdb"
  db_subnet_name  = "my-docdb-subnet"
  db_name         = "app"
  master_username = "admin"
  master_password = "SecurePassword123"

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
| db_name | The database a grant targets; DocumentDB creates it on first write. Output only. | `string` | `"app"` | no |
| aws_default_region | The AWS region where resources will be created | `string` | `"us-east-1"` | no |
| docdb_name | The cluster identifier of the DocumentDB cluster | `string` | `"test-docdb"` | no |
| db_subnet_name | The name of the DocumentDB subnet group | `string` | `"db_subnet_name"` | no |
| master_username | Username for the master DB user | `string` | n/a | yes |
| master_password | Password for the master DB user | `string` | n/a | yes |
| security_group_ids | List of VPC security group IDs to associate with the DocumentDB cluster | `list(string)` | n/a | yes |
| subnet_ids | List of subnet IDs to include in the DocumentDB subnet group | `list(string)` | n/a | yes |
| engine_version | The DocumentDB engine version; IAM authentication needs 5.0 | `string` | `"5.0.0"` | no |
| instance_class | The instance class of the cluster instance | `string` | `"db.t3.medium"` | no |
| port | The port on which the cluster accepts connections | `number` | `27017` | no |
| storage_encrypted | Specifies whether the cluster is encrypted at rest | `bool` | `true` | no |
| skip_final_snapshot | Determines whether a final snapshot is created before the cluster is deleted | `bool` | `true` | no |
| cloud_tags | Additional tags as a map to apply to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster_identifier | The cluster identifier of the DocumentDB cluster |
| arn | The ARN of the DocumentDB cluster |
| endpoint | The writer endpoint of the DocumentDB cluster |
| reader_endpoint | The reader endpoint of the DocumentDB cluster |
| port | The port on which the cluster accepts connections |
| master_username | Username for the master DB user |
| db_endpoint | The writer endpoint of the DocumentDB cluster |
| db_port | The port on which the cluster accepts connections |
| db_name | The database a grant targets |
| db_subnet_group_name | The name of the DocumentDB subnet group |
| engine_version | The DocumentDB engine version of the cluster |
| instance_class | The instance class of the cluster instance |
| storage_encrypted | Whether the DocumentDB cluster is encrypted at rest |

## License

Copyright (C) 2025 Gary Leong <gary@config0.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3 of the License.
