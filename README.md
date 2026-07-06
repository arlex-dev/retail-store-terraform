# Retail Store — Terraform Infrastructure on AWS

## Overview
This project provisions the complete AWS infrastructure for the retail store
microservices application using Terraform. One terraform apply command creates
the entire infrastructure and automatically deploys the application.

## Remote State Management

| Resource | Purpose |
|---|---|
| S3 Bucket | Stores terraform.tfstate file |
| DynamoDB Table | Handles state locking |
| Encryption | AES256 server-side encryption |
| Versioning | Enabled on S3 bucket |

## Tech Stack

| Category | Technology |
|---|---|
| IaC | Terraform v1.10.5 |
| Cloud | AWS us-east-1 |
| Compute | EC2 t2.medium |
| OS | Ubuntu 22.04 LTS |
| Storage | EBS gp3 30GB |
| State Backend | S3 + DynamoDB |
| Containerization | Docker and Docker Compose |

## Project Structure

main.tf         - VPC, Subnet, SG, EC2 resources
variables.tf    - All input variables
outputs.tf      - Public IP, URL, SSH command
backend.tf      - S3 + DynamoDB remote state
bootstrap.tf    - S3 bucket and DynamoDB table
user_data.sh    - Auto-installs Docker and deploys app
.gitignore      - Ignores sensitive files

## Outputs After Apply

After running terraform apply you will see:

instance_id       = <EC2 instance ID>
public_ip         = <EC2 public IP>
retail_store_url  = http://\<public_ip\>:8888
ssh_command       = ssh -i ~/.ssh/<key-name>.pem ubuntu@<public_ip>
vpc_id            = <VPC ID>
security_group_id = <Security Group ID>

## How to Use

Prerequisites:
- Terraform >= 1.0
- AWS CLI configured
- AWS key pair created

Step 1 - Clone the repo:
    git clone https://github.com/arlex-dev/retail-store-terraform.git
    cd retail-store-terraform

Step 2 - Create S3 and DynamoDB first:
    mv backend.tf backend.tf.bak
    terraform init
    terraform apply -target=aws_s3_bucket.terraform_state \
      -target=aws_s3_bucket_versioning.terraform_state \
      -target=aws_s3_bucket_server_side_encryption_configuration.terraform_state \
      -target=aws_s3_bucket_public_access_block.terraform_state \
      -target=aws_dynamodb_table.terraform_lock

Step 3 - Enable S3 backend:
    mv backend.tf.bak backend.tf
    terraform init -migrate-state

Step 4 - Deploy full infrastructure:
    terraform apply

Step 5 - Access the app after 10 minutes:
    http://\<public_ip\>:8888

## Destroy
    terraform destroy

## Key Learnings
- Writing Terraform code for AWS infrastructure
- Using S3 and DynamoDB for remote state management
- Automating application deployment with user_data scripts
- Managing sensitive variables with Terraform
- Two-step bootstrap pattern for remote state

## Related Projects
- retail-store-microservices: Docker Compose local deployment
- retail-store-cicd-jenkins: Jenkins CI/CD pipeline on AWS
- retail-store-terraform: This repo - Terraform IaC

## Author
Arlex - Cloud and DevOps Engineer
GitHub: https://github.com/arlex-dev
Stack: AWS | Docker | Jenkins | Terraform | Kubernetes
