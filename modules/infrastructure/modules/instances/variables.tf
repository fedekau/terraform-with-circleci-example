variable "environment" {}

variable "vpc-id" {}
variable "vpc-cidr-block" {}

variable "public-a-subnet-id" {}
variable "public-b-subnet-id" {}

variable "numberOfInstances" {
  default = 2
}

variable "db_endpoint" {}
