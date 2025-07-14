# Secure Serverless API with DevSecOps

A pet project demonstrating a secure serverless API on AWS with DevSecOps practices.

## Architecture
- **IaC**: Terraform (modular, `for_each`).
- **Application**: AWS Lambda (Python), API Gateway, DynamoDB.
- **Security**: WAF, Cognito, Checkov, Trivy, Bandit.
- **CI/CD**: GitHub Actions.
- **Monitoring**: CloudWatch, GuardDuty.
