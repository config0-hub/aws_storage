# AWS S3 Bucket Creation

## Description
This stack creates an S3 bucket in AWS with configurable options including versioning, lifecycle rules, and access control.

## Variables

### Required Variables

| Name | Description | Default |
|------|-------------|---------|
| bucket | S3 bucket name | &nbsp; |
| acl | S3 bucket access permissions | _random |

### Optional Variables

| Name | Description | Default |
|------|-------------|---------|
| versioning | Enables versioning for the S3 bucket | None |
| force_destroy | Allows bucket to be destroyed even when it contains objects | None |
| enable_lifecycle | Enables lifecycle rules for the bucket | None |
| noncurrent_version_expiration | Enables expiration of noncurrent versions | None |
| expire_days | Days until object expiration | &nbsp; |
| aws_default_region | Default AWS region | eu-west-1 |

## Dependencies

### Substacks
- [config0-publish:::tf_executor](http://config0.http.redirects.s3-website-us-east-1.amazonaws.com/assets/stacks/config0-publish/tf_executor/default)

### Execgroups
- [config0-publish:::aws_storage::buckets](http://config0.http.redirects.s3-website-us-east-1.amazonaws.com/assets/exec/groups/config0-publish/aws_storage/buckets/default)

### Shelloutconfigs
- [config0-publish:::terraform::resource_wrapper](http://config0.http.redirects.s3-website-us-east-1.amazonaws.com/assets/shelloutconfigs/config0-publish/terraform/resource_wrapper/default)

## License
<pre>
Copyright (C) 2025 Gary Leong <gary@config0.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3 of the License.
</pre>