# AWS DynamoDB Table Module

This module creates an AWS DynamoDB table with configurable settings for hash key, billing mode, and TTL.

## Usage

```hcl
module "dynamodb_table" {
  source = "path/to/module"

  dynamodb_name = "my-dynamodb-table"
  hash_key      = "id"
  billing_mode  = "PAY_PER_REQUEST"
  cloud_tags    = {
    Environment = "production"
    Owner       = "data-team"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| OpenTofu | >= 1.8.8 |
| AWS Provider | >= 4.0 |

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dynamodb_name | Name of the DynamoDB table | string | n/a | yes |
| billing_mode | Controls how you are charged for read and write throughput - valid values are PROVISIONED or PAY_PER_REQUEST | string | "PAY_PER_REQUEST" | no |
| hash_key | The attribute to use as the hash (partition) key | string | "_id" | no |
| product | Product name tag to apply to the DynamoDB table | string | "dynamodb" | no |
| aws_default_region | The AWS region to deploy the DynamoDB table | string | "eu-west-1" | no |
| cloud_tags | Additional tags as a map to apply to the DynamoDB table | map(string) | {} | no |

## Outputs

| Name | Description |
|------|-------------|
| billing_mode | The billing mode of the DynamoDB table |
| arn | The ARN of the DynamoDB table |
| hash_key | The hash key of the DynamoDB table |

## Features

- Creates a single DynamoDB table
- Configurable hash key
- TTL enabled by default with attribute name "expire_at"
- Flexible tagging support

## Notes

- This module creates a basic DynamoDB table with a single hash key
- For more complex configurations (GSIs, LSIs, etc.), you may need to extend this module

## License

Copyright (C) 2025 Gary Leong <gary@config0.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3 of the License.