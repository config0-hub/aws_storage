# AWS DynamoDB Stack

## Description
This stack creates and manages an AWS DynamoDB table using Terraform.

## Variables

### Required Variables

| Name | Description | Default |
|------|-------------|---------|
| dynamodb_name | Configuration for name | |

### Optional Variables

| Name | Description | Default |
|------|-------------|---------|
| hash_key | Configuration for hash key | `_id` |
| billing_mode | Configuration for billing mode | `PAY_PER_REQUEST` |
| aws_default_region | Default AWS region | `eu-west-1` |

## Features
- Creates a fully managed DynamoDB table in AWS
- Configurable hash key and billing mode
- Outputs important resource information including billing mode, ARN, and hash key

## Dependencies

### Substacks
- [config0-publish:::tf_executor](https://api-app.config0.com/web_api/v1.0/stacks/config0-publish/tf_executor)

### Execgroups
- [config0-publish:::aws_storage::dynamodb](https://api-app.config0.com/web_api/v1.0/exec/groups/config0-publish/aws_storage/dynamodb)

## License
Copyright (C) 2025 Gary Leong <gary@config0.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3 of the License.