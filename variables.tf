variable "region" {
  type    = string
  default = "us-east-1"
}

variable "create_lambda" {
  type    = bool
  default = false
}

variable "integration_uri_lb" {
  type    = string
  default = "http://aeb88d55333df4e3d92d2cbcc667f494-2b39a0f69558a653.elb.us-east-1.amazonaws.com"
}