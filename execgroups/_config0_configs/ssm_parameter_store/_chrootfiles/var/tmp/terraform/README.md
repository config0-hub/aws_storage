# AWS SSM Parameter Module

This module creates an AWS Systems Manager (SSM) Parameter for storing configuration values or secrets.

## Usage

```hcl
module "ssm_parameter" {
  source = "path/to/this/module"
  
  ssm_key         = "/dev/database/mysql/password"
  ssm_value       = "supersecretpassword"
  ssm_description = "MySQL database password for dev environment"
  
  cloud_tags = {
    Environment = "development"
    Project     = "my-project"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| opentofu | >= 1.8.8 |
| aws | >= 5.0.0 |

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws_default_region | The AWS region where resources will be created | `string` | `"us-east-2"` | no |
| ssm_type | The type of SSM parameter (String, StringList, or SecureString) | `string` | `"SecureString"` | yes |
| ssm_description | Human-readable description for the SSM parameter | `string` | `"The parameter description"` | no |
| ssm_key | The name/path of the SSM parameter (e.g., /dev/database/mysql/password) | `string` | n/a | yes |
| ssm_value | The value to be stored in the SSM parameter | `string` | n/a | yes |
| cloud_tags | Additional AWS resource tags as a map | `map(string)` | `{}` | no |

## Outputs

This module doesn't provide any outputs. Add outputs as needed for your use case.

## Best Practices

1. Use hierarchical paths for SSM parameters to organize them logically
2. Always use `SecureString` for sensitive information like passwords
3. Apply appropriate IAM permissions to control access to parameters
4. Use parameter versions for tracking changes
5. Apply consistent tagging strategy for better resource management

## License

Copyright (C) 2025 Gary Leong <gary@config0.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3 of the License.