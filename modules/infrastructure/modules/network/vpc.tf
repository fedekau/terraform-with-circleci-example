data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags {
    Name        = "${var.prefix}-${var.environment}-main"
    environment = "${var.environment}"
  }
}
