# AWS EBS Volume Terraform Module

This Terraform module creates an AWS EBS (Elastic Block Store) volume with configurable parameters. The module encrypts the volume by default and allows for custom tagging.

## Usage

```hcl
module "ebs_volume" {
  source = "path/to/module"

  aws_default_region = "ap-southeast-1"
  availability_zone  = "ap-southeast-1a"
  volume_size        = 20
  volume_name        = "data-storage"
  volume_type        = "gp3"
  
  cloud_tags = {
    Environment = "Production"
    Team        = "DevOps"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| aws | >= 4.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws_default_region | The AWS region where resources will be created (e.g., ap-southeast-1) | `string` | n/a | yes |
| availability_zone | The availability zone where the EBS volume will be created | `string` | n/a | yes |
| volume_size | The size of the EBS volume in GiB | `number` | `10` | no |
| volume_name | The name to assign to the EBS volume | `string` | `"data"` | no |
| volume_type | The type of EBS volume (gp2, gp3, io1, io2, sc1, st1, standard) | `string` | `"gp2"` | no |
| cloud_tags | Additional tags to apply to the EBS volume as a map | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| availability_zone | The availability zone where the EBS volume is created |
| arn | The ARN of the created EBS volume |
| volume_id | The ID of the created EBS volume |

## License

Copyright (C) 2025 Gary Leong <gary@config0.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3 of the License.