# AWS Redshift Module

This OpenTofu module creates an AWS Redshift provisioned cluster with a dedicated cluster subnet group.

## Features

- Creates an encrypted Redshift cluster, single-node by default (`ra3.large`)
- Sets up a dedicated cluster subnet group for the cluster
- Not publicly accessible by default; no final snapshot on deletion

## Usage

```hcl
module "redshift" {
  source = "./path/to/module"

  redshift_name       = "my-redshift"
  cluster_subnet_name = "my-redshift-subnet"
  db_name             = "analytics"
  master_username     = "admin"
  master_password     = "SecurePassword123"

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
| db_name | The name of the first database created when the cluster is created | `string` | `"dev"` | no |
| aws_default_region | The AWS region where resources will be created | `string` | `"us-east-1"` | no |
| redshift_name | The cluster identifier of the Redshift cluster | `string` | `"test-redshift"` | no |
| cluster_subnet_name | The name of the Redshift cluster subnet group | `string` | `"cluster_subnet_name"` | no |
| master_username | Username for the master DB user | `string` | n/a | yes |
| master_password | Password for the master DB user | `string` | n/a | yes |
| security_group_ids | List of VPC security group IDs to associate with the Redshift cluster | `list(string)` | n/a | yes |
| subnet_ids | List of subnet IDs to include in the cluster subnet group | `list(string)` | n/a | yes |
| node_type | The node type of the Redshift cluster | `string` | `"ra3.large"` | no |
| number_of_nodes | The number of compute nodes; 1 makes a single-node cluster | `number` | `1` | no |
| port | The port on which the cluster accepts connections | `number` | `5439` | no |
| publicly_accessible | Controls if the cluster is publicly accessible | `bool` | `false` | no |
| encrypted | Specifies whether the cluster is encrypted at rest | `bool` | `true` | no |
| skip_final_snapshot | Determines whether a final snapshot is created before the cluster is deleted | `bool` | `true` | no |
| cloud_tags | Additional tags as a map to apply to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster_identifier | The cluster identifier of the Redshift cluster |
| arn | The ARN of the Redshift cluster |
| cluster_namespace_arn | The namespace ARN of the Redshift cluster |
| endpoint | The connection endpoint of the Redshift cluster, host:port |
| dns_name | The DNS name of the Redshift cluster |
| port | The port on which the cluster accepts connections |
| database_name | The name of the first database in the cluster |
| cluster_subnet_group_name | The name of the Redshift cluster subnet group |
| node_type | The node type of the Redshift cluster |
| number_of_nodes | The number of compute nodes in the Redshift cluster |
| publicly_accessible | Whether the Redshift cluster is publicly accessible |
| encrypted | Whether the Redshift cluster is encrypted at rest |

## License

Copyright (C) 2025 Gary Leong <gary@config0.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3 of the License.
