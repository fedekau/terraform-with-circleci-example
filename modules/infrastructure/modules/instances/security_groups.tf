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
