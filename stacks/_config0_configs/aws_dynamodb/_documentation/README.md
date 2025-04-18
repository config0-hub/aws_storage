# AWS DynamoDB Stack

## Description
This stack creates and manages an AWS DynamoDB table using Terraform.

## Variables

### Required Variables

| Name | Description | Default |
|------|-------------|---------|
| dynamodb_name | Configuration for DynamoDB table name | &nbsp; |

### Optional Variables

| Name | Description | Default |
|------|-------------|---------|
| hash_key | Configuration for hash key | `_id` |
| billing_mode | Configuration for billing mode | `PAY_PER_REQUEST` |
| aws_default_region | Default AWS region | `eu-west-1` |

## Dependencies

### Substacks
- [config0-publish:::tf_executor](http://config0.http.redirects.s3-website-us-east-1.amazonaws.com/assets/stacks/config0-publish/tf_executor/default)

### Execgroups
- [config0-publish:::aws_storage::dynamodb](http://config0.http.redirects.s3-website-us-east-1.amazonaws.com/assets/exec/groups/config0-publish/aws_storage/dynamodb/default)

### Shelloutconfigs
- [config0-publish:::terraform::resource_wrapper](http://config0.http.redirects.s3-website-us-east-1.amazonaws.com/assets/shelloutconfigs/config0-publish/terraform/resource_wrapper/default)

## License
<pre>
Copyright (C) 2025 Gary Leong <gary@config0.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3 of the License.
</pre>