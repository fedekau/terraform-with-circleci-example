resource "aws_security_group" "allow-external-ssh" {
  name        = "allow-external-ssh"
  description = "Allow incoming ssh connections from the world."
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow-internal-ssh" {
  name        = "allow-internal-ssh"
  description = "Allow incoming ssh connections from the VPC."
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${aws_vpc.main.cidr_block}"]
  }
}
