    
provider "aws" {
  region = "${var.region}"
}

module "production-state" {
  source      = "../../modules/state"
  prefix      = "${var.prefix}"
  environment = "${var.environment}"
}

terraform {
  backend "s3" {
    bucket  = "production-state-terraform-circleci-lab"
    key     = "eg/terraform.tfstate"
    region  = "us-west-2"
    encrypt = true
  }
}

module "production-infrastructure" {
  source      = "../../modules/infrastructure"
  prefix      = "${var.prefix}"
  environment = "${var.environment}"
}
