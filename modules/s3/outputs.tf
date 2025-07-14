output "website_endpoint" {
  description = "The website endpoint for the S3 bucket"
  value       = "http://${aws_s3_bucket.website.bucket_domain_name}" 
}