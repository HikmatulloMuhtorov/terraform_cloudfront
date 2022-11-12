
resource "aws_cloudfront_distribution" "s3_distribution" {
  depends_on = [
    aws_s3_bucket.main
  ]

  origin {
    domain_name = aws_s3_bucket.main.bucket_domain_name 
    origin_id   = "cloudfront_s3"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.s3_distribution.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  aliases             = ["www.hmuhtorov.link", "hmuhtorov.link"]

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }


  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "cloudfront_s3"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 240000
  }

  price_class = "PriceClass_100"
  tags        = merge(local.common_tags, { Name = replace(local.name, "rtype", "s3c-main") })
  viewer_certificate {
    acm_certificate_arn = data.aws_acm_certificate.main.arn
    ssl_support_method  = "sni-only"
  }
}
resource "aws_cloudfront_origin_access_identity" "s3_distribution" {
}