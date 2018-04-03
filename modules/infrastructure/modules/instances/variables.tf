variable "environment" {}

variable "vpc-id" {}
variable "vpc-cidr-block" {}

variable "public-a-subnet-id" {}
variable "public-b-subnet-id" {}

variable "count" {
  default = 1
}

variable "db_endpoint" {}
