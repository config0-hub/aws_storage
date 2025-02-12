resource "aws_dynamodb_table" "default" {
  name             = var.dynamodb_name
  billing_mode     = var.billing_mode
  hash_key         = var.hash_key

  attribute {
    name = var.hash_key
    type = "S"
  }

  ttl {
    attribute_name = "expire_at"
    enabled        = true
  }

  tags = merge(
    var.cloud_tags,
    {
      Product = var.product
    },
  )
}

output "billing_mode" {
  value = aws_dynamodb_table.default.billing_mode
}

output "arn" {
  value = aws_dynamodb_table.default.arn
}

output "hash_key" {
  value = aws_dynamodb_table.default.hash_key
}