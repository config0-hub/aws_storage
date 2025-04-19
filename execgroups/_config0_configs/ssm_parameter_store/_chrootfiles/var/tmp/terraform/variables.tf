variable "aws_default_region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "us-east-2"
}

variable "ssm_type" {
  description = "The type of SSM parameter (String, StringList, or SecureString)"
  type        = string
  default     = "SecureString"
  validation {
    condition     = contains(["String", "StringList", "SecureString"], var.ssm_type)
    error_message = "The ssm_type must be one of: String, StringList, or SecureString."
  }
}

variable "ssm_description" {
  description = "Human-readable description for the SSM parameter"
  type        = string
  default     = "The parameter description"
}

variable "ssm_key" {
  description = "The name/path of the SSM parameter (e.g., /dev/database/mysql/password)"
  type        = string
}

variable "ssm_value" {
  description = "The value to be stored in the SSM parameter"
  type        = string
  sensitive   = true
}

variable "cloud_tags" {
  description = "Additional AWS resource tags as a map"
  type        = map(string)
  default     = {}
}