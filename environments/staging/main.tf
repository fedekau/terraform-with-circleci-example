provider "aws" {
  region = "${var.region}"
}

module "staging-state" {
  source = "../../modules/state"

  environment = "${var.environment}"
}

terraform {
  backend "s3" {
    bucket  = "staging-state-file"
    key     = "terraform.tfstate"
    region  = "us-west-1"
    encrypt = true
  }
}

module "staging-infrastructure" {
  source = "../../modules/infrastructure"

  environment = "${var.environment}"
}

output "web-alb-dns-name" {
  value = "${module.staging-infrastructure.web-alb-dns-name}"
}

output "web-instance-ips" {
  value = "${module.staging-infrastructure.web-instance-ips}"
}
