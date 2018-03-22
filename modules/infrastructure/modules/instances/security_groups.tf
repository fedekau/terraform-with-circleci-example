resource "aws_security_group" "allow-external-ssh" {
  name        = "allow-external-ssh"
  description = "Allow incoming ssh connections from the world."
  vpc_id      = "${var.vpc-id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow-all-http-outgoing" {
  name        = "allow-all-http-outgoing"
  description = "Allow outgoing http connections to the world."
  vpc_id      = "${var.vpc-id}"

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
