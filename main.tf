module "lambda" {
  source                  = "./modules/lambda"
  region                  = var.region
}

module "api-gateway" {
  source     = "./modules/api-gateway"
  lambda_arn = module.lambda.lambda_arn
}

module "dynamodb" {
  source = "./modules/dynamodb"
  tables = var.tables
}

module "s3" {
  source          = "./modules/s3"
  api_gateway_url = module.api-gateway.api_url
}

resource "null_resource" "lambda_permission" {
  depends_on = [module.lambda, module.api-gateway]
  
  provisioner "local-exec" {
    command = "aws lambda add-permission --function-name secure-api-lambda --statement-id AllowAPIGatewayInvoke --action lambda:InvokeFunction --principal apigateway.amazonaws.com --source-arn ${module.api-gateway.execution_arn}/*/*/* --region ${var.region}"
  }
}