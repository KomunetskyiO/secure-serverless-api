# Secure Serverless API with DevSecOps

A pet project demonstrating a secure serverless API on AWS with DevSecOps practices.

## Architecture
- **IaC**: Terraform (modular, `for_each`).
- **Application**: AWS Lambda (Python), API Gateway, DynamoDB.
- **Security**: WAF, Cognito, Checkov, Trivy, Bandit.
- **CI/CD**: GitHub Actions.
- **Monitoring**: CloudWatch, GuardDuty.

## Setup
1. Install Terraform, AWS CLI, Python.
2. Run `terraform init` and `terraform apply`.
3. Configure GitHub Actions with AWS credentials.

## Status
In progress: Lambda and IAM configured.