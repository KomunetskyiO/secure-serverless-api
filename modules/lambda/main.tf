data "aws_caller_identity" "current" {}

resource "aws_iam_role" "lambda_role" {
  name = "lambda-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "example" {
  function_name = "secure-api-lambda"
  handler       = "main.handler"
  runtime       = "python3.9"
  filename      = "${path.module}/../../lambda.zip"
  role          = aws_iam_role.lambda_role.arn
  environment {
    variables = {
      GREETING_MESSAGE = "Welcome to the Secure API project,"
    }
  }
}

resource "aws_lambda_permission" "api_gateway" {
  count = var.api_gateway_execution_arn != "" ? 1 : 0
  
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.example.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.api_gateway_execution_arn}/*/*/*"
}

resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda-dynamodb-policy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "dynamodb:PutItem",
          "dynamodb:Scan",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem"
        ],
        Resource = "arn:aws:dynamodb:us-east-1:${data.aws_caller_identity.current.account_id}:table/Tasks"
      }
    ]
  })
}