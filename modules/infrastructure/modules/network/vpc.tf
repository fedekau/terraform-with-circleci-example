data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags {
    name        = "${var.prefix}-main"
    environment = "${var.environment}"
  }
}
