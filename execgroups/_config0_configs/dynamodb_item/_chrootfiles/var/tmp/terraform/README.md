# DynamoDB CodeBuild Settings Module

A simple OpenTofu module for storing CodeBuild configuration in DynamoDB.

## Overview

This module creates a DynamoDB table item containing CodeBuild configuration settings encoded as a JSON string. It's designed to work with AWS CodeBuild services to store build configuration parameters.

## Requirements

- OpenTofu >= 1.8.8
- AWS provider

## Usage

```hcl
module "codebuild_settings" {
  source = "./path/to/module"

  table_name = "codebuild-ci-settings"
  hash_key   = "_id"
  item_hash  = "base64_encoded_json_string"
  
  cloud_tags = {
    Environment = "Production"
    Project     = "MyApp"
  }
}
```

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws_default_region | Default AWS region for resources | string | `"eu-west-1"` | no |
| item_hash | Base64 encoded JSON string representing the DynamoDB item to store | string | *Long base64 string* | no |
| table_name | Name of the DynamoDB table where item will be stored | string | `"codebuild-ci-settings"` | no |
| hash_key | Name of the hash key for the DynamoDB table | string | `"_id"` | no |
| cloud_tags | Additional tags to apply to resources as a map | map(string) | `{}` | no |

## Notes

- The `item_hash` contains a base64-encoded JSON string with various CodeBuild settings.
- This module assumes the DynamoDB table already exists. It only creates an item within that table.
- The hash_key must match the primary key of the existing DynamoDB table.

## License

Copyright (C) 2025 Gary Leong <gary@config0.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3 of the License.