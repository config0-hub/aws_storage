# AWS SSM Parameter resource for storing configuration values or secrets
resource "aws_ssm_parameter" "secret" {
  name        = var.ssm_key
  description = var.ssm_description
  type        = var.ssm_type
  value       = var.ssm_value
  tags        = var.cloud_tags # Best practice: apply tags to resources
}

