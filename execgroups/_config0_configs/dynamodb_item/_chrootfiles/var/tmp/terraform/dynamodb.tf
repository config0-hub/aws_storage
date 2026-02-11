# Create an item in the specified DynamoDB table
resource "aws_dynamodb_table_item" "default" {
  table_name = var.table_name
  hash_key   = var.hash_key
  item       = base64decode(var.item_hash)
}