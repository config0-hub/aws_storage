variable "aws_default_region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "ecr_repo" {
  description = "Name of the ECR repository to create"
  type        = string
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository. Valid values are MUTABLE or IMMUTABLE"
  type        = string
  default     = "MUTABLE"
}

variable "image_scanning_configuration" {
  description = "Configuration block that defines image scanning configuration for the repository"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "A map of tags to assign to the ECR repository"
  type        = map(string)
  default     = {}
}

variable "scan_on_push" {
  description = "Indicates whether images are scanned after being pushed to the repository (true) or not scanned (false)"
  type        = bool
  default     = true
}

variable "cloud_tags" {
  description = "Additional tags as a map"
  type        = map(string)
  default     = {}
}

variable "lifecycle_policy" {
  description = "JSON formatted ECR lifecycle policy to apply to the repository"
  type        = string
  default     = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 15 images",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": ["test","dev"],
                "countNumber": 15,
                "countType": "imageCountMoreThan"
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}

