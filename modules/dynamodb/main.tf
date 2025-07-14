resource "aws_dynamodb_table" "tables" {
  for_each     = var.tables
  name         = each.key
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = each.value.hash_key
  attribute {
    name = each.value.hash_key
    type = "S"
  }
}