resource "aws_s3_bucket" "access_logs" {
    bucket = local.s3_bucket_name
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