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

  environment = "${var.environment}"
}

output "web-alb-dns-name" {
  value = "${module.production-infrastructure.web-alb-dns-name}"
}

output "web-instance-ips" {
  value = "${module.production-infrastructure.web-instance-ips}"
}
