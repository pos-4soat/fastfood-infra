data "aws_availability_zones" "available" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

resource "aws_security_group" "rds_sg" {
  name_prefix = "rds-"

  ingress {
    from_port   = 1433
    to_port     = 1433
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow inbound traffic from any IP address.
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["45.185.168.173/32"]
  }

    egress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

# Retrieve the Auto Scaling Group associated with the EKS nodes
data "aws_autoscaling_groups" "eks_node_groups" {
  filter {
    name   = "tag:KubernetesCluster"
    values = [var.cluster_name]
  }
}

# Extract security group IDs from the Auto Scaling Group
locals {
  node_group_security_groups = [
    for asg in data.aws_autoscaling_groups.eks_node_groups.names : asg.launch_template[0].security_group_names
  ]
}

# Flatten the list of security group IDs
locals {
  flattened_security_groups = flatten(local.node_group_security_groups)
}

# Allow inbound traffic from the EKS node groups to the RDS instance
resource "aws_security_group_rule" "allow_eks_nodes_to_rds" {
  for_each = toset(local.flattened_security_groups)

  type              = "ingress"
  from_port         = 1433
  to_port           = 1433
  protocol          = "tcp"
  security_group_id = aws_security_group.rds_sg.id
  source_security_group_id = each.value
}

resource "aws_security_group_rule" "allow_eks_nodes" {
  for_each = toset(local.flattened_security_groups)

  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.rds_sg.id
  source_security_group_id = each.value
}