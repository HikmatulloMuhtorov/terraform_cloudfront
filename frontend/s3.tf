resource "aws_s3_bucket" "main" {
  bucket = "static-website-bucket-hik"
  acl    = "private"
  tags        = merge(local.common_tags, { Name = replace(local.name, "rtype", "s3-main") })
}
resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  bucket = aws_s3_bucket.main.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
resource "aws_s3_bucket_public_access_block" "main" {
  bucket = aws_s3_bucket.main.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "OAI" {
  bucket = aws_s3_bucket.main.id
  policy = data.aws_iam_policy_document.s3_policy.json
}

resource "aws_s3_bucket_object" "snake" {
  bucket = aws_s3_bucket.main.id
  key    = "index.html"
  source = "index.html"
}