variable "product" {
  description = "Product name tag to apply to the DynamoDB table"
  type        = string
  default     = "dynamodb"
}

variable "aws_default_region" {
  description = "The AWS region to deploy the DynamoDB table"
  type        = string
  default     = "eu-west-1"
}

variable "dynamodb_name" {
  description = "Name of the DynamoDB table"
  type        = string
}

variable "billing_mode" {
  description = "Controls how you are charged for read and write throughput - valid values are PROVISIONED or PAY_PER_REQUEST"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "hash_key" {
  description = "The attribute to use as the hash (partition) key"
  type        = string
  default     = "_id"
}

variable "cloud_tags" {
  description = "Additional tags as a map to apply to the DynamoDB table"
  type        = map(string)
  default     = {}
}

