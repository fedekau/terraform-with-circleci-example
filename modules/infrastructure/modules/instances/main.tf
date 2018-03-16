data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "web" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"

  subnet_id       = "${var.public-a-subnet-id}"
  security_groups = ["${var.allow-ssh-sg-id}"]

  key_name = "${aws_key_pair.id_rsa_kauffman_federico.key_name}"

  tags {
    environment = "${var.environment}"
  }
}

resource "aws_key_pair" "id_rsa_kauffman_federico" {
  key_name   = "id_rsa_kauffman_federico"
  public_key = "${file("~/.ssh/id_rsa_kauffman_federico.pub")}"
}
