output "arn" {
  description = "ARN of the created S3 bucket"
  value       = aws_s3_bucket.default.arn
}