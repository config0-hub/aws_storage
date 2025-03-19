# AWS EBS Volume Creation Stack

## Description
This stack creates an AWS Elastic Block Storage (EBS) volume in a specified availability zone. It can determine the availability zone automatically from an existing EC2 instance if not explicitly provided.

## Variables

### Required
| Name | Description | Default |
|------|-------------|---------|
| volume_name | Storage volume name | |
| volume_size | Storage volume size (GB) | 10 |

### Optional
| Name | Description | Default |
|------|-------------|---------|
| availability_zone | AWS availability zone for the EBS volume | null |
| hostname | Server hostname | null |
| instance_id | EC2 instance ID | null |
| aws_default_region | Default AWS region | eu-west-1 |

## Features
- Automatic availability zone detection from an existing EC2 instance
- Creates a named EBS volume with specified size
- Reports volume ID for easy reference

## Dependencies

### Substacks
- [config0-publish:::tf_executor](https://api-app.config0.com/web_api/v1.0/stacks/config0-publish/tf_executor)

### Execgroups
- [config0-publish:::aws_storage::ebs_volume](https://api-app.config0.com/web_api/v1.0/exec/groups/config0-publish/aws_storage/ebs_volume)

## License
Copyright (C) 2025 Gary Leong <gary@config0.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3 of the License.
