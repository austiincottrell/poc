resource "aws_s3_bucket" "access_logs" {
    bucket = "${local.s3_bucket_name}.${random_string.random.result}"
    acl    = "private"

    server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }
  }

    versioning {
        enabled = true
    }

    tags = {
        Name = local.s3_bucket_name
    }  
}

resource "random_string" "random" {
  length = 25
  special = false
  upper = false
  number = false
}
