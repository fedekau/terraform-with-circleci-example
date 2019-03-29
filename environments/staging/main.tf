provider "aws" {
  region = "${var.region}"
}

module "staging-state" {
  source = "../../modules/state"
  prefix      = "${var.prefix}"
  environment = "${var.environment}"
}

terraform {
  backend "s3" {
    bucket  = "eg-staging-state-file-terraform-circleci-lab"
    key     = "terraform.tfstate"
    region  = "us-west-2"
    encrypt = true
  }
}

module "staging-infrastructure" {
  source = "../../modules/infrastructure"
  prefix      = "${var.prefix}"
  environment = "${var.environment}"
}
