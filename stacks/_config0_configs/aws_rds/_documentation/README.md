# AWS RDS MySQL Database Stack

## Description
This stack creates and configures an AWS RDS MySQL database instance with customizable parameters, security groups, and subnet associations.

## Variables

### Required Variables

| Name | Description | Default |
|------|-------------|---------|
| subnet_ids | Subnet ID list | |
| sg_id | Security group ID | |
| rds_name | Configuration for name | |

### Optional Variables

| Name | Description | Default |
|------|-------------|---------|
| db_name | Database name | `_random` |
| allocated_storage | Database allocated storage | `30` |
| engine | Database engine | `MySQL` |
| engine_version | Database engine version | `8.0.35` |
| instance_class | Database instance type | `db.t3.micro` |
| multi_az | Enable multi-AZ deployment | `false` |
| storage_type | Database storage type | `gp2` |
| publicly_accessible | Make database publicly accessible | `false` |
| storage_encrypted | Enable storage encryption | `false` |
| allow_major_version_upgrade | Allow major version upgrades | `true` |
| auto_minor_version_upgrade | Allow minor version upgrades | `true` |
| skip_final_snapshot | Skip final snapshot on deletion | `true` |
| port | Database port | `3306` |
| backup_retention_period | Backup retention period in days | `1` |
| backup_window | Preferred backup window | `10:22-11:22` |
| maintenance_window | Preferred maintenance window | `Mon:00:00-Mon:03:00` |
| rds_master_username | Database admin username | `None` |
| rds_master_password | Database admin password | `None` |
| aws_default_region | Default AWS region | `eu-west-1` |
| publish_creds | Configuration for publish creds | `None` |
| publish_to_saas | boolean to publish values to config0 SaaS UI | `None` |
| timeout | Configuration for timeout | `2700` |

## Features
- Creates a managed MySQL RDS instance in AWS
- Configures security groups and subnet associations
- Generates random master username and password if not provided
- Supports publishing credentials to the Config0 SaaS UI
- Customizable instance size, storage, and backup configurations

## Dependencies

### Substacks
- [config0-publish:::tf_executor](https://api-app.config0.com/web_api/v1.0/stacks/config0-publish/tf_executor)

### Execgroups
- [config0-publish:::aws_storage::rds](https://api-app.config0.com/web_api/v1.0/exec/groups/config0-publish/aws_storage/rds)

## License
Copyright (C) 2025 Gary Leong <gary@config0.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3 of the License.
