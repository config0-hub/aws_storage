# AWS ECR Repository Stack

## Description
This stack creates and manages Amazon ECR (Elastic Container Registry) repositories in AWS. It can create a new repository or import an existing one that's not already tracked in Config0.

## Variables

### Required Variables
| Name | Description | Default |
|------|-------------|---------|
| ecr_repo | Name of the ECR repository | |

### Optional Variables
| Name | Description | Default |
|------|-------------|---------|
| aws_default_region | Default AWS region | eu-west-1 |

## Features
- Creates new ECR repositories in AWS
- Detects and imports existing ECR repositories not tracked in Config0
- Maps repository_uri to repository_url for consistency

## Dependencies

### Substacks
- [config0-publish:::tf_executor](https://api-app.config0.com/web_api/v1.0/stacks/config0-publish/tf_executor)

### Execgroups
- [config0-publish:::aws_storage::ecr_repo](https://api-app.config0.com/web_api/v1.0/exec/groups/config0-publish/aws_storage/ecr_repo)

## License
Copyright (C) 2025 Gary Leong <gary@config0.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3 of the License.