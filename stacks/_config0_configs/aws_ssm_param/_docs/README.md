# AWS SSM Parameter Store Stack

## Description
This stack creates an AWS SSM Parameter Store entry using Terraform. It allows you to securely store and manage configuration data, secrets, and other parameters.

## Variables

### Required Variables

| Name | Description | Default |
|------|-------------|---------|
| ssm_value | Parameter value to store in SSM | &nbsp; |
| ssm_key | SSM parameter key name | _random |

### Optional Variables

| Name | Description | Default |
|------|-------------|---------|
| ssm_type | Type of SSM parameter | SecureString |
| ssm_description | Description for the SSM parameter | &nbsp; |
| aws_default_region | Default AWS region | eu-west-1 |

## Dependencies

### Substacks
- [config0-publish:::tf_executor](http://config0.http.redirects.s3-website-us-east-1.amazonaws.com/assets/stacks/config0-publish/tf_executor/default)

### Execgroups
- [config0-publish:::aws_storage::ssm_parameter_store](http://config0.http.redirects.s3-website-us-east-1.amazonaws.com/assets/exec/groups/config0-publish/aws_storage/ssm_parameter_store/default)

### Shelloutconfigs
- [config0-publish:::terraform::resource_wrapper](http://config0.http.redirects.s3-website-us-east-1.amazonaws.com/assets/shelloutconfigs/config0-publish/terraform/resource_wrapper/default)

## License
<pre>
Copyright (C) 2025 Gary Leong <gary@config0.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3 of the License.
</pre>