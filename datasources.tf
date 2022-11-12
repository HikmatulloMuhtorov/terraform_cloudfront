data "aws_acm_certificate" "main" {
  domain      = "hmuhtorov.link"
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}
data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.main.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.s3_distribution.iam_arn]
    }
  }
}
data "aws_caller_identity" "current" {
}