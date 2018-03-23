resource "aws_instance" "web" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"

  subnet_id = "${var.public-a-subnet-id}"

  vpc_security_group_ids = [
    "${aws_security_group.allow-external-ssh.id}",
    "${aws_security_group.allow-all-http-outgoing.id}",
    "${aws_security_group.allow-mysql-egress.id}",
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
