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

resource "aws_instance" "db" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"

  subnet_id              = "${var.private-a-subnet-id}"
  vpc_security_group_ids = ["${var.allow-internal-ssh-sg-id}"]

  key_name = "id_rsa_kauffman_federico"

  tags {
    environment = "${var.environment}"
  }
}

# resource "aws_key_pair" "id_rsa_kauffman_federico" {
#   key_name   = "id_rsa_kauffman_federico"
#   public_key = "${file("~/.ssh/id_rsa_kauffman_federico.pub")}"
# }

