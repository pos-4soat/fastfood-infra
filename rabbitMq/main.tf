resource "aws_mq_broker" "rabbitmq" {
  broker_name        = "my-rabbitmq-broker"
  engine_type        = "RabbitMQ"
  engine_version     = "3.8.11"
  instance_type      = "mq.t2.micro"
  publicly_accessible = true
  security_groups    = [aws_security_group.mq_sg.id]
  subnet_ids         = var.private_subnets_ids
  users {
    username = "rabbitUser"
    password = "rabbitPwd"
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