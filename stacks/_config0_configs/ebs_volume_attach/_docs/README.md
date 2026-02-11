# AWS EBS Volume Attachment

## Description
This stack attaches an existing EBS volume to an EC2 instance. It retrieves the instance and volume IDs using the provided hostname and volume name, then creates the attachment using Terraform.

## Variables

### Required

| Name | Description | Default |
|------|-------------|---------|
| hostname | Server hostname | &nbsp; |

### Optional

| Name | Description | Default |
|------|-------------|---------|
| volume_name | Storage volume name | `<hostname>-data` |
| device_name | Configuration for device name | `/dev/xvdc` |
| aws_default_region | Default AWS region | `eu-west-1` |

## Dependencies

### Substacks
- [config0-publish:::tf_executor](http://config0.http.redirects.s3-website-us-east-1.amazonaws.com/assets/stacks/config0-publish/tf_executor/default)

### Execgroups
- [config0-publish:::aws_storage::attach_volume_to_ec2](http://config0.http.redirects.s3-website-us-east-1.amazonaws.com/assets/exec/groups/config0-publish/aws_storage/attach_volume_to_ec2/default)

### Shelloutconfigs
- [config0-publish:::terraform::resource_wrapper](http://config0.http.redirects.s3-website-us-east-1.amazonaws.com/assets/shelloutconfigs/config0-publish/terraform/resource_wrapper/default)

## License
<pre>
Copyright (C) 2025 Gary Leong <gary@config0.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3 of the License.
</pre>