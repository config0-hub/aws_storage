output "registry_id" {
  description = "The registry ID where the repository was created"
  value       = aws_ecr_repository.ecr_repository.registry_id
}

output "repository_url" {
  description = "The URL of the repository"
  value       = aws_ecr_repository.ecr_repository.repository_url
}

output "repository_uri" {
  description = "The URI of the repository"
  value       = aws_ecr_repository.ecr_repository.repository_url
}

output "arn" {
  description = "Full ARN of the repository"
  value       = aws_ecr_repository.ecr_repository.arn
}
