resource "aws_route53_zone" "main" {
  name = "hmuhtorov.link"
  tags        = merge(local.common_tags, { Name = replace(local.name, "rtype", "sg-main") })
}
resource "aws_route53_record" "aws_cloudfront_distribution" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "hmuhtorov.link"
  type    = "A"


  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = true
  }
}
resource "aws_route53_record" "aws_cloudfront_distribution_www" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "www.hmuhtorov.link"
  type    = "A"


  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = true
  }
}
