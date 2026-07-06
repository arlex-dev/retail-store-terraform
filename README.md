# Retail Store — Terraform Infrastructure on AWS

## Overview
This project provisions the complete AWS infrastructure for a microservices
retail store application using Terraform. A single terraform apply command
creates the entire infrastructure and automatically deploys the application
via a user_data bootstrap script.

## How It Works

Step 1 - terraform apply provisions AWS infrastructure
Step 2 - EC2 instance launches with user_data script
Step 3 - user_data installs Docker and Docker Compose
Step 4 - user_data clones the retail store repo
Step 5 - user_data builds images and runs docker compose up
Step 6 - App is live automatically at port 8888

## Remote State Management

| Resource | Purpose |
|---|---|
| S3 Bucket | Stores terraform.tfstate securely |
| DynamoDB Table | Prevents concurrent state changes |
| Encryption | AES256 server-side encryption on S3 |
| Versioning | Full history of state changes |

## Tech Stack

| Category | Technology |
|---|---|
| IaC | Terraform v1.10.5 |
| Cloud Provider | AWS us-east-1 |
| Compute | EC2 t2.medium |
| OS | Ubuntu 22.04 LTS |
| Storage | EBS gp3 30GB |
| State Backend | S3 + DynamoDB |
| Containerization | Docker and Docker Compose |

## Project Structure

main.tf         - VPC, Subnet, IGW, Route Table, SG, EC2
variables.tf    - All configurable input variables
outputs.tf      - Instance ID, public IP, app URL
backend.tf      - S3 and DynamoDB remote state config
bootstrap.tf    - Creates S3 bucket and DynamoDB table
user_data.sh    - Bootstraps Docker and deploys the app
.gitignore      - Excludes state files and secrets

## Prerequisites
- Terraform >= 1.0 installed
- AWS CLI installed and configured
- AWS key pair created in your account
- IAM user with EC2, S3, DynamoDB permissions

## How to Deploy

Step 1 - Clone the repo:
    git clone https://github.com/arlex-dev/retail-store-terraform.git
    cd retail-store-terraform

Step 2 - Update variables.tf with your values:
    key_name    = your AWS key pair name
    aws_region  = your preferred region

Step 3 - Create S3 and DynamoDB for remote state:
    mv backend.tf backend.tf.bak
    terraform init
    terraform apply -target=aws_s3_bucket.terraform_state \
      -target=aws_s3_bucket_versioning.terraform_state \
      -target=aws_s3_bucket_server_side_encryption_configuration.terraform_state \
      -target=aws_s3_bucket_public_access_block.terraform_state \
      -target=aws_dynamodb_table.terraform_lock

Step 4 - Enable remote backend:
    mv backend.tf.bak backend.tf
    terraform init -migrate-state

Step 5 - Deploy full infrastructure:
    terraform apply

Step 6 - Wait 10
Step 6 - Wait 10 minutes then access the app:
    http://\<your-public-ip\>:8888

## Destroy All Resources
    terraform destroy

## Key Learnings
- Writing Terraform code for real AWS infrastructure
- Two-step bootstrap pattern for remote state
- Using S3 and DynamoDB for secure state management
- Automating full app deployment with user_data scripts
- Managing infrastructure variables and sensitive values

## Related Projects
- retail-store-microservices: Docker Compose local deployment
- retail-store-cicd-jenkins: Jenkins CI/CD pipeline on AWS EC2
- retail-store-terraform: This repo — Terraform IaC on AWS

## Author
Arlex — Cloud and DevOps Engineer
GitHub: https://github.com/arlex-dev
Stack: AWS | Terraform | Docker | Jenkins | Kubernetes
