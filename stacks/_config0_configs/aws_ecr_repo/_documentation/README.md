**Description**
  - This stack creates an Elastic Container Repository (ECR) in AWS.
  - If the ECR already exists, it will not take any action.

| argument             | description                            | var type |  default     |
| -------------        | -------------------------------------- | -------- | ------------ |
| ecr_repo             | name of the ecr                        | string   | None         |
| aws_default_region   | default aws region                     | string   | us-east-1    |


**Sample entry**

```
infrastructure:
   ecr_repo:
       stack_name: config0-publish:::aws_ecr_repo
       arguments:
          ecr_repo: flask_sample
```
