# AWS ECR Repository Stack

## Description
This stack creates and manages Amazon ECR (Elastic Container Registry) repositories in AWS. It can create a new repository or import an existing one that's not already tracked in Config0.

## Variables

### Required Variables
| Name | Description | Default |
|------|-------------|---------|
| ecr_repo | Name of the ECR repository | &nbsp; |

### Optional Variables
| Name | Description | Default |
|------|-------------|---------|
| aws_default_region | Default AWS region | eu-west-1 |

## Dependencies

### Substacks
- [config0-publish:::tf_executor](http://config0.http.redirects.s3-website-us-east-1.amazonaws.com/assets/stacks/config0-publish/tf_executor/default)

### Execgroups
- [config0-publish:::aws_storage::ecr_repo](http://config0.http.redirects.s3-website-us-east-1.amazonaws.com/assets/exec/groups/config0-publish/aws_storage/ecr_repo/default)

### Shelloutconfigs
- [config0-publish:::terraform::resource_wrapper](http://config0.http.redirects.s3-website-us-east-1.amazonaws.com/assets/shelloutconfigs/config0-publish/terraform/resource_wrapper/default)

## License
<pre>
Copyright (C) 2025 Gary Leong <gary@config0.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3 of the License.
</pre>