provider "aws" {
  region = "${var.region}"
}

module "production-state" {
  source = "../../modules/state"

  environment = "${var.environment}"
}

terraform {
  backend "s3" {
    bucket  = "biorad-production-state-file-terraform-circleci-lab-eg"
    key     = "terraform.tfstate"
    region  = "us-west-2"
    encrypt = true
  }
}

module "production-infrastructure" {
  source = "../../modules/infrastructure"
  prefix      = "${var.prefix}"
  environment = "${var.environment}"
}
