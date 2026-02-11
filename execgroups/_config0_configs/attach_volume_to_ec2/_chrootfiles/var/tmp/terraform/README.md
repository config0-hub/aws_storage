# AWS EBS Volume Attachment Module

This OpenTofu/Terraform module attaches an existing EBS volume to an EC2 instance.

## Usage

```hcl
module "ebs_attachment" {
  source = "path/to/module"
  
  volume_id    = "vol-0123456789abcdef0"
  instance_id  = "i-0123456789abcdef0"
  device_name  = "/dev/xvdc"
}
```

## Requirements

| Name | Version |
|------|---------|
| opentofu | >= 1.8.0 |
| aws | >= 4.0 |

## Resources

| Name | Type |
|------|------|
| [aws_volume_attachment.data-vol-attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/volume_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| volume_id | ID of the EBS volume to attach to the instance | `string` | n/a | yes |
| instance_id | ID of the instance to attach the volume to | `string` | n/a | yes |
| device_name | Device name to expose to the instance | `string` | `/dev/xvdc` | no |
| aws_default_region | AWS region where resources will be deployed, e.g. ap-southeast-1 | `string` | n/a | yes |
| cloud_tags | Additional tags to apply to resources as a map | `map(string)` | `{}` | no |

## Note

This module uses `force_detach = true` which means the volume will be forcefully detached when the Terraform destroy is run. Use with caution as this can lead to data corruption if the volume is in use.

## License

Copyright (C) 2025 Gary Leong <gary@config0.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3 of the License.