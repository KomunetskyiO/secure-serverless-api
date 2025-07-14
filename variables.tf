variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "tables" {
  description = "DynamoDB tables"
  type        = map(object({ hash_key = string }))
  default = {
    "tasks" = { hash_key = "id" }
    "logs"  = { hash_key = "log_id" }
  }
}