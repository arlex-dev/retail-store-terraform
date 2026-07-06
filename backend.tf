terraform {
  backend "s3" {
    bucket         = "retail-store-terraform-state-248068895172"
    key            = "retail-store/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "retail-store-terraform-lock"
    encrypt        = true
  }
}
