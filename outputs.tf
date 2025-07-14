output "api_url" {
  description = "API Gateway URL"
  value       = module.api-gateway.api_url
}

output "website_url" {
  description = "URL of the deployed website"
  value       = module.s3.website_endpoint
}