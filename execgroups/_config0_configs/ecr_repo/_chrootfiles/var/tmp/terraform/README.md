# AWS ECR Repository Terraform Module

This module creates an AWS Elastic Container Registry (ECR) repository with a configurable lifecycle policy and security settings.

## Features

- Creates an ECR repository with configurable settings
- Configures image tag mutability
- Sets up image scanning on push
- Implements AES256 encryption
- Configures a lifecycle policy to manage image retention

## Usage

```hcl
module "ecr" {
  source = "path/to/module"

  ecr_repo             = "my-application"
  image_tag_mutability = "IMMUTABLE"
  scan_on_push         = true
  
  tags = {
    Environment = "production"
    Team        = "platform"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws_default_region | The AWS region where resources will be created | `string` | `"us-east-1"` | no |
| ecr_repo | Name of the ECR repository to create | `string` | n/a | yes |
| image_tag_mutability | The tag mutability setting for the repository. Valid values are MUTABLE or IMMUTABLE | `string` | `"MUTABLE"` | no |
| image_scanning_configuration | Configuration block that defines image scanning configuration for the repository | `map` | `{}` | no |
| tags | A map of tags to assign to the ECR repository | `map(string)` | `{}` | no |
| scan_on_push | Indicates whether images are scanned after being pushed to the repository | `bool` | `true` | no |
| cloud_tags | Additional tags as a map | `map(string)` | `{}` | no |
| lifecycle_policy | JSON formatted ECR lifecycle policy to apply to the repository | `string` | See default in variables section | no |

## Outputs

| Name | Description |
|------|-------------|
| registry_id | The registry ID where the repository was created |
| repository_url | The URL of the repository |
| arn | Full ARN of the repository |

## Default Lifecycle Policy

The default lifecycle policy will retain the last 15 images tagged with either "test" or "dev" prefixes and expire any additional images.

## License

Copyright (C) 2025 Gary Leong <gary@config0.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3 of the License.