# AWS S3 Bucket Creation

## Description
This stack creates an S3 bucket in AWS with configurable options including versioning, lifecycle rules, and access control.

## Variables

### Required Variables

| Name | Description | Default |
|------|-------------|---------|
| bucket | S3 bucket name |  |
| acl | S3 bucket access permissions | _random |

### Optional Variables

| Name | Description | Default |
|------|-------------|---------|
| versioning | Enables versioning for the S3 bucket | None |
| force_destroy | Allows bucket to be destroyed even when it contains objects | None |
| enable_lifecycle | Enables lifecycle rules for the bucket | None |
| noncurrent_version_expiration | Enables expiration of noncurrent versions | None |
| expire_days | Days until object expiration | None |
| aws_default_region | Default AWS region | eu-west-1 |

## Features
- Create S3 buckets with custom configurations
- Configure bucket access control lists
- Enable or disable versioning
- Set up lifecycle rules for object expiration
- Configure force destroy options

## Dependencies

### Substacks
- [config0-publish:::tf_executor](https://api-app.config0.com/web_api/v1.0/stacks/config0-publish/tf_executor)

### Execgroups
- [config0-publish:::aws_storage::buckets](https://api-app.config0.com/web_api/v1.0/exec/groups/config0-publish/aws_storage/buckets)

## License
Copyright (C) 2025 Gary Leong <gary@config0.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3 of the License.