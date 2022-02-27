provider "aws" {
	region = var.aws_region
}

resource "aws_cloudfront_distribution" "mira" {


  dynamic "origin" {
    for_each = [for i in var.dynamic_s3_origin_config : {
      name                     = i.domain_name
      id                       = i.origin_id
      path                     = lookup(i, "origin_path", "") 
      oai                      = lookup(i, "origin_access_identity", "")
	    connection_attempts      = i.connection_attempts
	    connection_timeout       = i.connection_timeout
  

    }]
    content {
      domain_name = origin.value.name
      origin_id   = origin.value.id
      origin_path = origin.value.path
      connection_attempts      = origin.value.connection_attempts
	    connection_timeout       = origin.value.connection_timeout

      s3_origin_config {
        origin_access_identity = origin.value.oai
      }
    }
  }
  dynamic "origin" {
    for_each = [for i in var.dynamic_custom_origin_config : {
      name                     = i.domain_name
      id                       = i.origin_id
      path                     = lookup(i, "origin_path", "") 
      http_port                = i.http_port
      https_port               = i.https_port
      origin_keepalive_timeout = i.origin_keepalive_timeout
      origin_read_timeout      = i.origin_read_timeout
      origin_protocol_policy   = i.origin_protocol_policy
      origin_ssl_protocols     = i.origin_ssl_protocols

    }]
    content {
      domain_name = origin.value.name
      origin_id   = origin.value.id
      origin_path = origin.value.path
      custom_origin_config {
        http_port                = origin.value.http_port
        https_port               = origin.value.https_port
        origin_keepalive_timeout = origin.value.origin_keepalive_timeout
        origin_read_timeout      = origin.value.origin_read_timeout
        origin_protocol_policy   = origin.value.origin_protocol_policy
        origin_ssl_protocols     = origin.value.origin_ssl_protocols
      }
    }
  }

  enabled             = var.enabled
  is_ipv6_enabled     = false
  default_root_object = var.default_root_object

  logging_config {
    include_cookies = var.logging_include_cookies
    bucket          = var.logging_bucket
    prefix          = var.logging_prefix
  }

  #aliases = var.aliases

  default_cache_behavior {
    allowed_methods  = var.default_cache_behavior_allowed_methods
    cached_methods   = var.default_cache_behavior_cached_methods
    target_origin_id = var.default_origin_id
    forwarded_values {
      query_string = var.default_cache_behavior_forwarded_values_query_string

      cookies {
        forward = var.default_cache_behavior_forwarded_values_cookies_forward
      }
    }

    viewer_protocol_policy = var.default_cache_behavior_viewer_protocol_policy
    min_ttl                = var.default_cache_behavior_min_ttl
    default_ttl            = var.default_cache_behavior_default_ttl
    max_ttl                = var.default_cache_behavior_max_ttl
  }

  # Cache behavior with precedence 0
  /*
  ordered_cache_behavior {
    path_pattern     = "/content/immutable/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = local.s3_origin_id
    forwarded_values {
      query_string = false
      headers      = ["Origin"]
      cookies {
        forward = "none"
      }
    }
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }
*/

  price_class = var.price_class

  tags = var.tags

  #viewer_certificate {
  #  cloudfront_default_certificate = var.cloudfront_default_certificate
  #  acm_certificate_arn 	  = var.acm_certificate_arn
  #  minimum_protocol_version = var.minimum_protocol_version
  #  ssl_support_method      = var.ssl_support_method
  #}

 viewer_certificate {
    cloudfront_default_certificate = true
  }
  
  restrictions {
	  geo_restriction {
		  restriction_type = "none"
	  }
  }
}

