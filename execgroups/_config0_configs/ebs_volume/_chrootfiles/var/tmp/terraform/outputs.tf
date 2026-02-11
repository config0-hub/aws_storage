output "availability_zone" {
  description = "The availability zone where the EBS volume is created"
  value       = var.availability_zone
}

output "arn" {
  description = "The ARN of the created EBS volume"
  value       = aws_ebs_volume.data-vol.arn
}

output "volume_id" {
  description = "The ID of the created EBS volume"
  value       = aws_ebs_volume.data-vol.id
}