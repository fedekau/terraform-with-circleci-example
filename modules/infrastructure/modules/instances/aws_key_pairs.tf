resource "aws_key_pair" "id_dummy" {
  key_name   = "${var.prefix}_${var.environment}_id_dummy"
  public_key = "${file("../../.keys/id_dummy.pub")}"
}
