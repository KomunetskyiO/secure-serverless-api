output "api_url" {
  value = aws_api_gateway_stage.example.invoke_url
}
output "stage_arn" {
  value = aws_api_gateway_stage.example.arn
}

output "execution_arn" {
  value = aws_api_gateway_rest_api.api.execution_arn
}