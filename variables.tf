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
  default = "http://aa805ca87a7a84245ad5553a688cb953-352154593.us-east-1.elb.amazonaws.com"
}

variable "order_uri_lb" {
  type    = string
  default = "http://a73acb1e7965d4e1286288f0a3621d2b-457653939.us-east-1.elb.amazonaws.com"
}

variable "payment_uri_lb" {
  type    = string
  default = "http://a89b05e80043745a89e878e92ab186a5-1759719953.us-east-1.elb.amazonaws.com"
}

variable "production_uri_lb" {
  type    = string
  default = "http://a16d3f766dcc547f7b60dd6987a776e7-1733068445.us-east-1.elb.amazonaws.com"
}
