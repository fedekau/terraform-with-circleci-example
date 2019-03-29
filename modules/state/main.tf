resource "aws_dynamodb_table" "state-file-locking-table" {
  name           = "${var.prefix}-${var.environment}-state-file-locking"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags {
    env = "${var.environment}"
    dept = "git"
    app  = "terraform-circleci-lab"
  }
}
