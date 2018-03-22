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

  subnet_id = "${var.public-a-subnet-id}"

  vpc_security_group_ids = [
    "${aws_security_group.allow-external-ssh.id}",
    "${aws_security_group.allow-all-http-outgoing.id}",
  ]

  key_name = "${aws_key_pair.id_dummy.key_name}"

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file("../../.keys/id_dummy")}"
    }

    inline = [
      "sudo apt-get install mysql-client -y",
    ]
  }

  tags {
    environment = "${var.environment}"
  }
}

resource "aws_key_pair" "id_dummy" {
  key_name   = "id_dummy"
  public_key = "${file("../../.keys/id_dummy.pub")}"
}
