module "lambda" {
  source = "./modules/lambda"
  region = var.region
}

module "api-gateway" {
  source     = "./modules/api-gateway"
  lambda_arn = module.lambda.lambda_arn
}

module "dynamodb" {
  source = "./modules/dynamodb"
  tables = var.tables
}