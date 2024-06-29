variable "region" {
  type    = string
  default = "us-east-1"
}

variable "create_lambda" {
  type    = bool
  default = false
}

variable "products_uri_lb" {
  type    = string
  default = "http://adcc3cf7e217a449da41b65abf3b6c76-1373874074.us-east-1.elb.amazonaws.com"
}

variable "order_uri_lb" {
  type    = string
  default = "http://afacd6eebe0b346d98c936b0b461ebac-1571231343.us-east-1.elb.amazonaws.com"
}

variable "payment_uri_lb" {
  type    = string
  default = "http://a45a20ee71a734df1a640486babf7387-602865925.us-east-1.elb.amazonaws.com"
}

variable "production_uri_lb" {
  type    = string
  default = "http://ac5de471384df4ef4a1875e8f27298be-692200852.us-east-1.elb.amazonaws.com"
}
