variable "api_name" {
  default = "FastFoodApi"
  type    = string
}

variable "protocol_type" {
  default = "HTTP"
  type    = string
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "api_version" {
  default = "1"
}



variable "cognito_user_pool_client_id" {}
variable "lambda_arn" {}
variable "cognito_user_pool_id" {}
variable "lambda_name" {}
variable "private_subnets_ids" {}
variable "security_group_id" {}
variable "products_uri_lb" {}
variable "order_uri_lb" {}
variable "payment_uri_lb" {}
variable "production_uri_lb" {}