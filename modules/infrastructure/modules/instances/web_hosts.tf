locals {
  subnets_ids = [
    "${var.public-a-subnet-id}",
    "${var.public-b-subnet-id}",
  ]
}

data "template_file" "init" {
  template = "${file("${path.module}/templates/init.tpl")}"
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

  # user_data = "${data.template_file.init.rendered}"

  provisioner "file" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file("../../.keys/id_dummy")}"
    }

    content     = "${data.template_file.init.rendered}"
    destination = "/home/ubuntu/init.sh"
  }
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file("../../.keys/id_dummy")}"
    }

    inline = [
      "chmod +x /home/ubuntu/init.sh",
      "sudo /home/ubuntu/init.sh",
    ]
  }
  tags {
    environment = "${var.environment}"
  }
}
