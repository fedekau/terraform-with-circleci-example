resource "aws_s3_bucket" "state-file-bucket" {
  bucket = "biorad-${var.environment}-state-file-terraform-circleci-lab-eg"

  versioning {
    enabled = true
  }

  tags {
    environment = "${var.environment}"
  }
}

resource "aws_dynamodb_table" "state-file-locking-table" {
  name           = "${var.environment}-state-file-locking-eg"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags {
    environment = "${var.environment}"
  }
}
