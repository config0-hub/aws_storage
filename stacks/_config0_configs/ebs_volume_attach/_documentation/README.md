**Description**

  - The stack attaches an ebs volume to an ec2 instance.

**Infrastructure**

  - expects ec2 and ebs to be already created.

**Required**

| argument      | description                            | var type | default      |
| ------------- | -------------------------------------- | -------- | ------------ |
| hostname   | the hostname to mount the volume       | string   | None         |
| aws_default_region   | aws region to create the ecr repo                | string   | us-east-1         |

**Optional**

| argument   | description                                             | var type | default                 |
|------------|---------------------------------------------------------| -------- |-------------------------|
| device_name | the device name for the volume                          | string   | /dev/xvdc               |
| tf_runtime | the terraform runtime for terraform execution | string   | tofu:1.6.2 |
| volume_name | the volume_name to mount on the hostname                | string   | <hostname>-name         |
