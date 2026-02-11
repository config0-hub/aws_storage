# AWS region configuration
variable "aws_default_region" {
  description = "Default AWS region for resources"
  type        = string
  default     = "eu-west-1"
}

# Base64 encoded JSON item to be stored in DynamoDB
variable "item_hash" {
  description = "Base64 encoded JSON string representing the DynamoDB item to store"
  type        = string
  default     = "eyJidWlsZF9pbWFnZSI6IHsiUyI6ICJhd3MvY29kZWJ1aWxkL3N0YW5kYXJkOjUuMCJ9LCAidHJpZ2dlcl9pZCI6IHsiUyI6ICIxMjM0NTYifSwgImRvY2tlcl9yZXBvX25hbWUiOiB7IlMiOiAiZmxhc2tfc2FtcGxlIn0sICJnaXRfdXJsIjogeyJTIjogImdpdEBnaXRodWIuY29tOmpvZWJsb3cvZmxhc2tfc2FtcGxlLXByaXZhdGUuZ2l0In0sICJnaXRfcmVwbyI6IHsiUyI6ICJmbGFzay1zYW1wbGUtcHJpdmF0ZSJ9LCAiYXdzX2RlZmF1bHRfcmVnaW9uIjogeyJTIjogImV1LXdlc3QtMSJ9LCAiX2lkIjogeyJTIjogIjEyMzQ1NiJ9LCAiaW1hZ2VfdHlwZSI6IHsiUyI6ICJMSU5VWF9DT05UQUlORVIifSwgImNvbXB1dGVfdHlwZSI6IHsiUyI6ICJCVUlMRF9HRU5FUkFMMV9TTUFMTCJ9LCAiYnVpbGRfdGltZW91dCI6IHsiUyI6ICI1In0sICJwcml2aWxlZ2VkX21vZGUiOiB7IlMiOiAidHJ1ZSJ9LCAic2VjcmV0IjogeyJTIjogInNlY3JldDEyMyJ9LCAiYnJhbmNoIjogeyJTIjogIm1hc3RlciJ9LCAiZG9ja2VyX3JlZ2lzdHJ5IjogeyJTIjogIm51bGwifSwgImNvZGVidWlsZF9uYW1lIjogeyJTIjogImZsYXNrLXNhbXBsZS1wcml2YXRlIn19"
}

# DynamoDB table name
variable "table_name" {
  description = "Name of the DynamoDB table where item will be stored"
  type        = string
  default     = "codebuild-ci-settings"
}

# Primary key name for the DynamoDB table
variable "hash_key" {
  description = "Name of the hash key for the DynamoDB table"
  type        = string
  default     = "_id"
}

# Additional resource tags
variable "cloud_tags" {
  description = "Additional tags to apply to resources as a map"
  type        = map(string)
  default     = {}
}

