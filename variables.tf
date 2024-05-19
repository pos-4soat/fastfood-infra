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
  default = "http://aaf158365ac594b9a935a5728cff86a4-477550370.us-east-1.elb.amazonaws.com"
}

variable "order_uri_lb" {
  type    = string
  default = "http://afddde2aa9a2349f19ea88a81368d68a-1980996683.us-east-1.elb.amazonaws.com"
}

variable "payment_uri_lb" {
  type    = string
  default = "http://adbabe667ae49490aace41d0d30d8d2a-58880327.us-east-1.elb.amazonaws.com"
}

variable "production_uri_lb" {
  type    = string
  default = "http://aba78a0d3d18f421a9719ce666d00116-1778465615.us-east-1.elb.amazonaws.com"
}