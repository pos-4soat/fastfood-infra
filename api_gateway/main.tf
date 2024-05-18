##################################### API

resource "aws_apigatewayv2_api" "ApiGateway" {
  name          = var.api_name
  protocol_type = var.protocol_type
}

##################################### AUTHORIZER

resource "aws_apigatewayv2_authorizer" "jwt_authorizer" {
  depends_on      = [aws_apigatewayv2_api.ApiGateway]
  api_id          = aws_apigatewayv2_api.ApiGateway.id
  name            = "jwt_authorizer"
  authorizer_type = "JWT"
  identity_sources = [
    "$request.header.Authorization"
  ]
  jwt_configuration {
    audience = [var.cognito_user_pool_client_id]
    issuer   = "https://cognito-idp.${var.region}.amazonaws.com/${var.cognito_user_pool_id}"
  }
}

##################################### INTEGRATION

resource "aws_apigatewayv2_vpc_link" "vpc_link_api_to_lb" {
  name               = "vpc_link_api_to_lb"
  security_group_ids = [var.security_group_id]
  subnet_ids         = var.private_subnets_ids
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  depends_on             = [aws_apigatewayv2_api.ApiGateway]
  api_id                 = aws_apigatewayv2_api.ApiGateway.id
  integration_type       = "AWS_PROXY"
  integration_method     = "POST"
  integration_uri        = var.lambda_arn
  payload_format_version = "2.0"
}

##################################### INTEGRATION PRODUCT

resource "aws_apigatewayv2_integration" "load_balancer_integration_product" {
  api_id             = aws_apigatewayv2_api.ApiGateway.id
  integration_type   = "HTTP_PROXY"
  integration_uri    = "${var.products_uri_lb}/v${var.api_version}/product"
  connection_type    = "INTERNET"
  integration_method = "ANY"
}

resource "aws_apigatewayv2_integration" "load_balancer_integration_product_id" {
  api_id             = aws_apigatewayv2_api.ApiGateway.id
  integration_type   = "HTTP_PROXY"
  integration_uri    = "${var.products_uri_lb}/v${var.api_version}/product/{id}"
  connection_type    = "INTERNET"
  integration_method = "ANY"
}

resource "aws_apigatewayv2_integration" "load_balancer_integration_product_category" {
  api_id             = aws_apigatewayv2_api.ApiGateway.id
  integration_type   = "HTTP_PROXY"
  integration_uri    = "${var.products_uri_lb}/v${var.api_version}/product/category/{type}"
  connection_type    = "INTERNET"
  integration_method = "ANY"
}

##################################### ROUTES PRODUCT

resource "aws_apigatewayv2_route" "load_balancer_route_product_" {
  depends_on         = [aws_apigatewayv2_integration.load_balancer_integration_product]
  api_id             = aws_apigatewayv2_api.ApiGateway.id
  route_key          = "ANY /v${var.api_version}/product"
  target             = "integrations/${aws_apigatewayv2_integration.load_balancer_integration_product.id}"
  authorizer_id      = aws_apigatewayv2_authorizer.jwt_authorizer.id
  authorization_type = "JWT"
}

resource "aws_apigatewayv2_route" "load_balancer_route_product_id" {
  depends_on         = [aws_apigatewayv2_integration.load_balancer_integration_product_id]
  api_id             = aws_apigatewayv2_api.ApiGateway.id
  route_key          = "ANY /v${var.api_version}/product/{id}"
  target             = "integrations/${aws_apigatewayv2_integration.load_balancer_integration_product_id.id}"
  authorizer_id      = aws_apigatewayv2_authorizer.jwt_authorizer.id
  authorization_type = "JWT"
}

resource "aws_apigatewayv2_route" "load_balancer_route_product_category" {
  depends_on         = [aws_apigatewayv2_integration.load_balancer_integration_product_category]
  api_id             = aws_apigatewayv2_api.ApiGateway.id
  route_key          = "ANY /v${var.api_version}/product/category/{type}"
  target             = "integrations/${aws_apigatewayv2_integration.load_balancer_integration_product_category.id}"
  authorizer_id      = aws_apigatewayv2_authorizer.jwt_authorizer.id
  authorization_type = "JWT"
}

##################################### INTEGRATION ORDER

resource "aws_apigatewayv2_integration" "load_balancer_integration_order" {
  api_id             = aws_apigatewayv2_api.ApiGateway.id
  integration_type   = "HTTP_PROXY"
  integration_uri    = "${var.order_uri_lb}/v${var.api_version}/order"
  connection_type    = "INTERNET"
  integration_method = "ANY"
}

resource "aws_apigatewayv2_integration" "load_balancer_integration_order_id" {
  api_id             = aws_apigatewayv2_api.ApiGateway.id
  integration_type   = "HTTP_PROXY"
  integration_uri    = "${var.order_uri_lb}/v${var.api_version}/order/{id}"
  connection_type    = "INTERNET"
  integration_method = "ANY"
}

resource "aws_apigatewayv2_integration" "load_balancer_integration_order_status" {
  api_id             = aws_apigatewayv2_api.ApiGateway.id
  integration_type   = "HTTP_PROXY"
  integration_uri    = "${var.order_uri_lb}/v${var.api_version}/order/status/{status}"
  connection_type    = "INTERNET"
  integration_method = "ANY"
}

resource "aws_apigatewayv2_integration" "load_balancer_integration_order_pending" {
  api_id             = aws_apigatewayv2_api.ApiGateway.id
  integration_type   = "HTTP_PROXY"
  integration_uri    = "${var.order_uri_lb}/v${var.api_version}/order/pending"
  connection_type    = "INTERNET"
  integration_method = "ANY"
}

##################################### ROUTES ORDER

resource "aws_apigatewayv2_route" "load_balancer_route_order_" {
  depends_on         = [aws_apigatewayv2_integration.load_balancer_integration_order]
  api_id             = aws_apigatewayv2_api.ApiGateway.id
  route_key          = "ANY /v${var.api_version}/order"
  target             = "integrations/${aws_apigatewayv2_integration.load_balancer_integration_order.id}"
  authorizer_id      = aws_apigatewayv2_authorizer.jwt_authorizer.id
  authorization_type = "JWT"
}

resource "aws_apigatewayv2_route" "load_balancer_route_order_id" {
  depends_on         = [aws_apigatewayv2_integration.load_balancer_integration_order_id]
  api_id             = aws_apigatewayv2_api.ApiGateway.id
  route_key          = "ANY /v${var.api_version}/order/{id}"
  target             = "integrations/${aws_apigatewayv2_integration.load_balancer_integration_order_id.id}"
  authorizer_id      = aws_apigatewayv2_authorizer.jwt_authorizer.id
  authorization_type = "JWT"
}

resource "aws_apigatewayv2_route" "load_balancer_route_order_status" {
  depends_on         = [aws_apigatewayv2_integration.load_balancer_integration_order_status]
  api_id             = aws_apigatewayv2_api.ApiGateway.id
  route_key          = "ANY /v${var.api_version}/order/status/{status}"
  target             = "integrations/${aws_apigatewayv2_integration.load_balancer_integration_order_status.id}"
  authorizer_id      = aws_apigatewayv2_authorizer.jwt_authorizer.id
  authorization_type = "JWT"
}

resource "aws_apigatewayv2_route" "load_balancer_route_order_pending" {
  depends_on         = [aws_apigatewayv2_integration.load_balancer_integration_order_pending]
  api_id             = aws_apigatewayv2_api.ApiGateway.id
  route_key          = "ANY /v${var.api_version}/order/pending"
  target             = "integrations/${aws_apigatewayv2_integration.load_balancer_integration_order_pending.id}"
  authorizer_id      = aws_apigatewayv2_authorizer.jwt_authorizer.id
  authorization_type = "JWT"
}

##################################### INTEGRATION PAYMENT

resource "aws_apigatewayv2_integration" "load_balancer_integration_payment" {
  api_id             = aws_apigatewayv2_api.ApiGateway.id
  integration_type   = "HTTP_PROXY"
  integration_uri    = "${var.payment_uri_lb}/v${var.api_version}/payment"
  connection_type    = "INTERNET"
  integration_method = "ANY"
}

resource "aws_apigatewayv2_integration" "load_balancer_integration_payment_id" {
  api_id             = aws_apigatewayv2_api.ApiGateway.id
  integration_type   = "HTTP_PROXY"
  integration_uri    = "${var.payment_uri_lb}/v${var.api_version}/payment/{id}"
  connection_type    = "INTERNET"
  integration_method = "ANY"
}

##################################### ROUTES PAYMENT

resource "aws_apigatewayv2_route" "load_balancer_route_payment_" {
  depends_on         = [aws_apigatewayv2_integration.load_balancer_integration_payment]
  api_id             = aws_apigatewayv2_api.ApiGateway.id
  route_key          = "ANY /v${var.api_version}/payment"
  target             = "integrations/${aws_apigatewayv2_integration.load_balancer_integration_payment.id}"
  authorizer_id      = aws_apigatewayv2_authorizer.jwt_authorizer.id
  authorization_type = "JWT"
}

resource "aws_apigatewayv2_route" "load_balancer_route_payment_id" {
  depends_on         = [aws_apigatewayv2_integration.load_balancer_integration_payment_id]
  api_id             = aws_apigatewayv2_api.ApiGateway.id
  route_key          = "ANY /v${var.api_version}/payment/{id}"
  target             = "integrations/${aws_apigatewayv2_integration.load_balancer_integration_payment_id.id}"
  authorizer_id      = aws_apigatewayv2_authorizer.jwt_authorizer.id
  authorization_type = "JWT"
}

##################################### INTEGRATION PRODUCTION

resource "aws_apigatewayv2_integration" "load_balancer_integration_production" {
  api_id             = aws_apigatewayv2_api.ApiGateway.id
  integration_type   = "HTTP_PROXY"
  integration_uri    = "${var.production_uri_lb}/v${var.api_version}/production"
  connection_type    = "INTERNET"
  integration_method = "ANY"
}

resource "aws_apigatewayv2_integration" "load_balancer_integration_production_id" {
  api_id             = aws_apigatewayv2_api.ApiGateway.id
  integration_type   = "HTTP_PROXY"
  integration_uri    = "${var.production_uri_lb}/v${var.api_version}/production/{id}"
  connection_type    = "INTERNET"
  integration_method = "ANY"
}

resource "aws_apigatewayv2_integration" "load_balancer_integration_production_status" {
  api_id             = aws_apigatewayv2_api.ApiGateway.id
  integration_type   = "HTTP_PROXY"
  integration_uri    = "${var.production_uri_lb}/v${var.api_version}/production/status/{status}"
  connection_type    = "INTERNET"
  integration_method = "ANY"
}

##################################### ROUTES PRODUCTION

resource "aws_apigatewayv2_route" "load_balancer_route_production_" {
  depends_on         = [aws_apigatewayv2_integration.load_balancer_integration_production]
  api_id             = aws_apigatewayv2_api.ApiGateway.id
  route_key          = "ANY /v${var.api_version}/production"
  target             = "integrations/${aws_apigatewayv2_integration.load_balancer_integration_production.id}"
  authorizer_id      = aws_apigatewayv2_authorizer.jwt_authorizer.id
  authorization_type = "JWT"
}

resource "aws_apigatewayv2_route" "load_balancer_route_production_id" {
  depends_on         = [aws_apigatewayv2_integration.load_balancer_integration_production_id]
  api_id             = aws_apigatewayv2_api.ApiGateway.id
  route_key          = "ANY /v${var.api_version}/production/{id}"
  target             = "integrations/${aws_apigatewayv2_integration.load_balancer_integration_production_id.id}"
  authorizer_id      = aws_apigatewayv2_authorizer.jwt_authorizer.id
  authorization_type = "JWT"
}

resource "aws_apigatewayv2_route" "load_balancer_route_production_status" {
  depends_on         = [aws_apigatewayv2_integration.load_balancer_integration_production_status]
  api_id             = aws_apigatewayv2_api.ApiGateway.id
  route_key          = "ANY /v${var.api_version}/production/status/{status}"
  target             = "integrations/${aws_apigatewayv2_integration.load_balancer_integration_production_status.id}"
  authorizer_id      = aws_apigatewayv2_authorizer.jwt_authorizer.id
  authorization_type = "JWT"
}

##################################### ROUTES LAMBDA

resource "aws_apigatewayv2_route" "lambda_route" {
  depends_on = [aws_apigatewayv2_api.ApiGateway, aws_apigatewayv2_integration.lambda_integration]
  api_id     = aws_apigatewayv2_api.ApiGateway.id
  route_key  = "ANY /User/{proxy+}"
  target     = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

##################################### STAGE

resource "aws_apigatewayv2_stage" "ApiGatewayStage" {
  depends_on  = [aws_apigatewayv2_api.ApiGateway]
  api_id      = aws_apigatewayv2_api.ApiGateway.id
  name        = "ApiGatewayStage"
  auto_deploy = true
}

##################################### PERMISSIONS

resource "aws_lambda_permission" "apigateway_invoke_lambda" {
  depends_on    = [aws_apigatewayv2_api.ApiGateway]
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.ApiGateway.execution_arn}/*/*/User/*"
}