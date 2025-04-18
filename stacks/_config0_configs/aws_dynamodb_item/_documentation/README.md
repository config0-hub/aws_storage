# DynamoDB Item

## Description
This stack creates and manages a DynamoDB item in an existing DynamoDB table on AWS. It provides a simple interface to insert or update items in DynamoDB tables.

## Variables

### Required
| Name | Description | Default |
|------|-------------|---------|
| table_name | DynamoDB table name | &nbsp; |
| item_hash | Hash value for the DynamoDB item | &nbsp; |

### Optional
| Name | Description | Default |
|------|-------------|---------|
| hash_key | Primary key name for the DynamoDB table | `_id` |
| aws_default_region | Default AWS region | `eu-west-1` |

## Dependencies

### Substacks
- [config0-publish:::tf_executor](http://config0.http.redirects.s3-website-us-east-1.amazonaws.com/assets/stacks/config0-publish/tf_executor/default)

### Execgroups
- [config0-publish:::aws_storage::dynamodb_item](http://config0.http.redirects.s3-website-us-east-1.amazonaws.com/assets/exec/groups/config0-publish/aws_storage/dynamodb_item/default)

### Shelloutconfigs
- [config0-publish:::terraform::resource_wrapper](http://config0.http.redirects.s3-website-us-east-1.amazonaws.com/assets/shelloutconfigs/config0-publish/terraform/resource_wrapper/default)

## License
<pre>
Copyright (C) 2025 Gary Leong <gary@config0.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3 of the License.
</pre>