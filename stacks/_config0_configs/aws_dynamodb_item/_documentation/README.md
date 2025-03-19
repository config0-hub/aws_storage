# DynamoDB Item

## Description
This stack creates and manages a DynamoDB item in an existing DynamoDB table on AWS. It provides a simple interface to insert or update items in DynamoDB tables.

## Variables

### Required
| Name | Description | Default |
|------|-------------|---------|
| table_name | DynamoDB table name | |
| item_hash | Hash value for the DynamoDB item | |

### Optional
| Name | Description | Default |
|------|-------------|---------|
| hash_key | Primary key name for the DynamoDB table | `_id` |
| aws_default_region | Default AWS region | `eu-west-1` |

## Features
- Creates or updates items in a DynamoDB table
- Supports custom primary key name configuration
- Managed through Terraform for infrastructure as code

## Dependencies

### Substacks
- [config0-publish:::tf_executor](https://api-app.config0.com/web_api/v1.0/stacks/config0-publish/tf_executor)

### Execgroups
- [config0-publish:::aws_storage::dynamodb_item](https://api-app.config0.com/web_api/v1.0/exec/groups/config0-publish/aws_storage/dynamodb_item)

## License
Copyright (C) 2025 Gary Leong <gary@config0.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3 of the License.