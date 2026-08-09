resource "aws_s3_bucket" "default" {
  bucket        = var.bucket
  acl           = var.acl
  force_destroy = var.force_destroy

  tags = merge(
    var.cloud_tags,
    {
      Product = "s3"
    },
  )

  versioning {
    enabled = var.versioning
  }

  lifecycle_rule {
    enabled = var.enable_lifecycle

    expiration {
      days = var.expire_days
    }

    noncurrent_version_expiration {
      days = var.noncurrent_version_expiration
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}


# ponytail: opt-in only. Default off means no policy resource for every other caller.
resource "aws_s3_bucket_policy" "engine_write" {
  count = var.engine_write_access ? 1 : 0

  bucket = aws_s3_bucket.default.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "Config0EngineWrite"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/config0-xe-codebuild"
        }
        Action   = "s3:PutObject"
        Resource = "${aws_s3_bucket.default.arn}/*"
      },
    ]
  })
}
