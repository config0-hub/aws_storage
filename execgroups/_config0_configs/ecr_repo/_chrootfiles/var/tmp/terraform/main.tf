resource "aws_ecr_repository" "ecr_repository" {
  name                 = var.ecr_repo
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

}

resource "aws_ecr_lifecycle_policy" "lifecycle_policy" {
  repository = aws_ecr_repository.ecr_repository.name
  policy     = var.lifecycle_policy
}

output "registry_id" {
  value = aws_ecr_repository.ecr_repository.registry_id
}

output "repository_url" {
  value = aws_ecr_repository.ecr_repository.repository_url
}

output "arn" {
  value = aws_ecr_repository.ecr_repository.arn
}