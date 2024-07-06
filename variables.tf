variable "region" {
  type    = string
  default = "us-east-1"
}

variable "create_lambda" {
  type    = bool
  default = true
}

variable "products_uri_lb" {
  type    = string
  default = "http://a0a5e6b9ab2c241fbb1660604d075934-1483141928.us-east-1.elb.amazonaws.com"
}

variable "order_uri_lb" {
  type    = string
  default = "http://a5a01068b370f40678f258d594d8ba46-1819846840.us-east-1.elb.amazonaws.com"
}

variable "payment_uri_lb" {
  type    = string
  default = "http://ab4ddd80e8ab442bb8dce9b446afbb97-1909483017.us-east-1.elb.amazonaws.com"
}

variable "production_uri_lb" {
  type    = string
  default = "http://a2b8c771323f44969b65f375df022ccf-441059606.us-east-1.elb.amazonaws.com"
}
