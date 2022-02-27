variable "default_origin_domain_name" {
	default = "cf-lb-origin-3654-0969119f5acc23c1.elb.us-east-1.amazonaws.com"
}
variable "default_origin_id" {
	default = "cf-lb-origin-3654"
}
variable "price_class" {
	default = "PriceClass_All"
}
variable "default_root_object" {
	default = "index.html"
}
variable "aws_region" {
  default = "us-east-1"
}

# variable "origins" {
# 	type = any
#  	default = {}
#    # 		"cf-origin-3654" = {
# # 			"domain_name" = "cf-origin-3654.s3.amazonaws.com"
# # 			"connection_attempts" = "3"
# # 			"connection_timeout" = "10"
# # 			"origin_path" = "/cf-origin"
# # 		}
# # 	}
#  }
variable dynamic_s3_origin_config {
  description = "Configuration for the s3 origin config to be used in dynamic block"
  type        = any
  default     = [
  {
    domain_name              = "cf-origin-3654.s3.amazonaws.com"
    origin_id                = "cf-origin-3654"
    origin_path              =  "/cf-origin"
    connection_attempts      = "3"
	  connection_timeout       = "10"
  },
  {
    domain_name              = "cf-origin2-3654.s3.amazonaws.com"
    origin_id                = "cf-origin2-3654"
    origin_path              =  "/cf-origin"
    connection_attempts      = "3"
	  connection_timeout       = "10"
  }
  ]
}

variable dynamic_custom_origin_config {
  description = "Configuration for the custom origin config to be used in dynamic block"
  type        = any
  default     = [
  {
    domain_name              = "cf-lb-origin-3654-0969119f5acc23c1.elb.us-east-1.amazonaws.com"
    origin_id                = "cf-lb-origin-3654"
    http_port                = 80
    https_port               = 443
    origin_keepalive_timeout = 5
    origin_read_timeout      = 30
    origin_protocol_policy   = "http-only"
    origin_ssl_protocols     = ["TLSv1.2", "TLSv1.1"]

  },
    {
    domain_name              = "cf-lb-origin2-8856a68f501de181.elb.us-east-1.amazonaws.com"
    origin_id                = "cf-lb-origin2"
    http_port                = 80
    https_port               = 443
    origin_keepalive_timeout = 5
    origin_read_timeout      = 30
    origin_protocol_policy   = "http-only"
    origin_ssl_protocols     = ["TLSv1.2", "TLSv1.1"]

  }
  ]
}

variable "enabled" {
	type = bool
	  default = true
}

# variable "aliases" {
#   type = list
#   default = ["dev.mira.umusic.net"]
# }

variable "logging_bucket" {
	default = "cf-origin-3654.s3.amazonaws.com"
}
variable "logging_prefix" {
	default = "logs"
}
variable "logging_include_cookies" {
	type = bool
	default = false
}

variable "tags" {
  type = map
  default =  {
	  "environment" = "dev"
}
}

# variable "cloudfront_default_certificate" {
# 	  type = bool
# 	  default = false
# }



variable "default_cache_behavior_allowed_methods" {
  type = list
  default = [
    "HEAD",
    "GET",
    "OPTIONS",
    "PUT",
    "PATCH",
    "POST",
    "DELETE"
  ]
}

variable "default_cache_behavior_cached_methods" {
  type = list
  default = [
    "HEAD",
    "GET",
    "OPTIONS"
  ]
}

variable "default_cache_behavior_forwarded_values_query_string" {
  type = bool
  default = false
}

variable "default_cache_behavior_forwarded_values_cookies_forward" {
	default = "none"
}

variable "default_cache_behavior_viewer_protocol_policy" {

	default = "allow-all"
}

variable "default_cache_behavior_min_ttl" {
	type = number
	default = 0
}

variable "default_cache_behavior_default_ttl" {
	type = number
	default = 0
}

variable "default_cache_behavior_max_ttl" {
	type = number
	default = 0
}
