# AWS SSM Parameter Store Stack

## Description
This stack creates an AWS SSM Parameter Store entry using Terraform. It allows you to securely store and manage configuration data, secrets, and other parameters.

## Variables

### Required Variables

| Name | Description | Default |
|------|-------------|---------|
| ssm_value | Parameter value to store in SSM | |
| ssm_key | SSM parameter key name | _random |

### Optional Variables

| Name | Description | Default |
|------|-------------|---------|
| ssm_type | Type of SSM parameter | SecureString |
| ssm_description | Description for the SSM parameter | |
| aws_default_region | Default AWS region | eu-west-1 |

## Features
- Creates an AWS SSM parameter with customizable key, value, and type
- Supports SecureString type for secure parameter storage
- Automatically generates parameter description if not provided

## Dependencies

### Substacks
- [config0-publish:::tf_executor](https://api-app.config0.com/web_api/v1.0/stacks/config0-publish/tf_executor)

### Execgroups
- [config0-publish:::aws_storage::ssm_parameter_store](https://api-app.config0.com/web_api/v1.0/exec/groups/config0-publish/aws_storage/ssm_parameter_store)

## License
Copyright (C) 2025 Gary Leong <gary@config0.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3 of the License.
