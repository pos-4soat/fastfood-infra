variable "region" {
  type    = string
  default = "us-east-1"
}

variable "create_lambda" {
  type    = bool
  default = true
}

variable "integration_uri_lb" {
  type    = string
  default = "http://a1f39ea83f95441a3893d731ea49d7ad-1681536253.us-east-1.elb.amazonaws.com"
}