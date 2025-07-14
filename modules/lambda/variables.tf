variable "region" {
  type = string
}

variable "api_gateway_execution_arn" {
  description = "Execution ARN of the API Gateway"
  type        = string
  default     = ""  # Making it optional with a default empty string
}