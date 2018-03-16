output "public-a-subnet-id" {
  value = "${aws_subnet.public-a.id}"
}

output "public-b-subnet-id" {
  value = "${aws_subnet.public-b.id}"
}

output "private-a-subnet-id" {
  value = "${aws_subnet.private-a.id}"
}

output "private-b-subnet-id" {
  value = "${aws_subnet.private-b.id}"
}

output "allow-ssh-sg-id" {
  value = "${aws_security_group.allow-ssh.id}"
}
