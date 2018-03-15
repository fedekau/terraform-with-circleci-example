provider "aws" {
  region = "${var.region}"
}

module "staging-state" {
  source = "../../modules/state"

  environment = "staging"
}

terraform {
  backend "s3" {
    bucket  = "staging-state-file"
    key     = "terraform.tfstate"
    region  = "us-west-1"
    encrypt = true
  }
}
