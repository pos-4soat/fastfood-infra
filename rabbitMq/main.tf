resource "aws_mq_broker" "rabbitmq" {
  broker_name                   = "my-rabbitmq-broker"
  deployment_mode               = "ACTIVE_STANDBY_MULTI_AZ"
  engine_type                   = "RabbitMQ"
  engine_version                = "3.12.13"
  host_instance_type            = "mq.t3.micro"
  auto_minor_version_upgrade    = false
  apply_immediately             = false
  security_groups               = [aws_security_group.mq_sg.id]
  subnet_ids                    = var.private_subnets_ids
  user {
    username = "rabbitUser"
    password = "rabbitPassword"
  }
}

resource "aws_security_group" "mq_sg" {
  name_prefix = "mq-"
  vpc_id = var.vpc_id

    ingress {
    from_port   = 5671
    to_port     = 5671
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}