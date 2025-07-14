output "api_url" {
  value = aws_api_gateway_stage.example.invoke_url
}
output "stage_arn" {
  value = aws_api_gateway_stage.example.arn
}