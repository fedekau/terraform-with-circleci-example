locals {
  subnets_ids = [
    "${var.public-a-subnet-id}",
    "${var.public-b-subnet-id}",
  ]
}

data "template_file" "init" {
  template = "${file("${path.module}/templates/init.tpl")}"

  vars = {
    db_endpoint = "${var.db_endpoint}"
    db_port     = 3306
    db_name     = "${var.environment}"
    db_username = "username"
    db_password = "password"
  }
}

data "template_file" "instance-status" {
  template = "${file("${path.module}/templates/instance-status.tpl")}"
}

resource "aws_instance" "web" {
  count = "${var.numberOfInstances}"

  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"

  subnet_id = "${element(local.subnets_ids, count.index)}"

  vpc_security_group_ids = [
    "${aws_security_group.web.id}",
  ]

  key_name = "${aws_key_pair.id_dummy.key_name}"

  tags = {
    environment = "${var.environment}"
  }
}

resource "null_resource" "web" {
  count = "${var.numberOfInstances}"

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = "${file("../../.keys/id_dummy")}"
    host        = "${element(aws_instance.web.*.public_ip, count.index)}"
  }

  provisioner "file" {
    content     = "${data.template_file.init.rendered}"
    destination = "/home/ubuntu/init.sh"
  }

  provisioner "file" {
    content     = "${data.template_file.instance-status.rendered}"
    destination = "/home/ubuntu/instance-status.conf"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/init.sh",
      "sudo /home/ubuntu/init.sh",
    ]
  }
}
