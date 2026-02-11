output "billing_mode" {
  description = "The billing mode of the DynamoDB table"
  value       = aws_dynamodb_table.default.billing_mode
}

output "arn" {
  description = "The ARN of the DynamoDB table"
  value       = aws_dynamodb_table.default.arn
}

output "hash_key" {
  description = "The hash key of the DynamoDB table"
  value       = aws_dynamodb_table.default.hash_key
}