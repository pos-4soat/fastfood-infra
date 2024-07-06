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
  default = "http://a82fa3b0214d44fa6a73d8c75e9252b1-1122316300.us-east-1.elb.amazonaws.com"
}

variable "order_uri_lb" {
  type    = string
  default = "http://a7c3be677959642be936c17ca14db374-2003574050.us-east-1.elb.amazonaws.com"
}

variable "payment_uri_lb" {
  type    = string
  default = "http://a4dc144b84d714d679b513845ed4ce8c-926484663.us-east-1.elb.amazonaws.com"
}

variable "production_uri_lb" {
  type    = string
  default = "http://ae0532b978cc54a08830e1837b4e06f5-560717098.us-east-1.elb.amazonaws.com"
}
