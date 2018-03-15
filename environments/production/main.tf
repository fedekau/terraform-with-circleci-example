provider "aws" {
  region = "${var.region}"
}

module "production-state" {
  source = "../../modules/state"

  environment = "production"
}

terraform {
  backend "s3" {
    bucket  = "production-state-file"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

module "production-infrastructure" {
  source = "../../modules/infrastructure"

  environment = "production"
}
