resource "aws_s3_bucket" "website" {
  bucket = "secure-api-website-demo-ok" 
}

### Configure S3 bucket for website hosting
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

### Allow public access
resource "aws_s3_bucket_public_access_block" "website" {
  bucket = aws_s3_bucket.website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

### Add bucket policy to allow public read access
resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.website.arn}/*"
      }
    ]
  })

  ### Make sure public access block is disabled first
  depends_on = [aws_s3_bucket_public_access_block.website]
}

resource "aws_s3_object" "config" {
  bucket       = aws_s3_bucket.website.id
  key          = "config.json"
  content      = jsonencode({ api_url = var.api_gateway_url })
  content_type = "application/json"
}