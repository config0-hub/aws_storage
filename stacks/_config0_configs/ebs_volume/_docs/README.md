# AWS EBS Volume Creation Stack

## Description
This stack creates an AWS Elastic Block Storage (EBS) volume in a specified availability zone. It can determine the availability zone automatically from an existing EC2 instance if not explicitly provided.

## Variables

### Required
| Name | Description | Default |
|------|-------------|---------|
| volume_name | Storage volume name | &nbsp; |
| volume_size | Storage volume size (GB) | 10 |

### Optional
| Name | Description | Default |
|------|-------------|---------|
| availability_zone | AWS availability zone for the EBS volume | null |
| hostname | Server hostname | null |
| instance_id | EC2 instance ID | null |
| aws_default_region | Default AWS region | eu-west-1 |

## Dependencies

### Substacks
- [config0-publish:::tf_executor](http://config0.http.redirects.s3-website-us-east-1.amazonaws.com/assets/stacks/config0-publish/tf_executor/default)

### Execgroups
- [config0-publish:::aws_storage::ebs_volume](http://config0.http.redirects.s3-website-us-east-1.amazonaws.com/assets/exec/groups/config0-publish/aws_storage/ebs_volume/default)

### Shelloutconfigs
- [config0-publish:::terraform::resource_wrapper](http://config0.http.redirects.s3-website-us-east-1.amazonaws.com/assets/shelloutconfigs/config0-publish/terraform/resource_wrapper/default)

## License
<pre>
Copyright (C) 2025 Gary Leong <gary@config0.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3 of the License.
</pre>