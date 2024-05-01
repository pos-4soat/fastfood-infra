resource "aws_cloudwatch_log_group" "FastFoodUserLogging" {
  name = var.cloudwatch_group_name
}