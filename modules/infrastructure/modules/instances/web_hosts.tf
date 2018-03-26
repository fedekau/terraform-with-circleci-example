locals {
  subnets_ids = [
    "${var.public-a-subnet-id}",
    "${var.public-b-subnet-id}",
  ]
}

resource "aws_instance" "web" {
  count = "2"

  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"

  subnet_id = "${element(local.subnets_ids, count.index)}"

  vpc_security_group_ids = [
    "${aws_security_group.web.id}",
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
      "curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -",
      "sudo apt-get install -y nodejs",
    ]
  }

  tags {
    environment = "${var.environment}"
  }
}
