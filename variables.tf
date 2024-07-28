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
  default = "http://a9eede1ff4a3d43408f16b54d11835dd-237774606.us-east-1.elb.amazonaws.com"
}

variable "order_uri_lb" {
  type    = string
  default = "http://a60fda211e6b34bd5b157869bab629c2-2049505118.us-east-1.elb.amazonaws.com"
}

variable "payment_uri_lb" {
  type    = string
  default = "http://a028270e204de4d328afc8b3fb2170ff-1769143137.us-east-1.elb.amazonaws.com"
}

variable "production_uri_lb" {
  type    = string
  default = "http://abefc3105ee0a4262896115d7e4da94b-968617408.us-east-1.elb.amazonaws.com"
}
