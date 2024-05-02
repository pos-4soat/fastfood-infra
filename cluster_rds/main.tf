resource "aws_iam_role" "eks-iam" {
  name = "eks-cluster-iam-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-iam.name
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.3"

  cluster_name    = var.cluster_name
  cluster_version = "1.29"

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
  }

  eks_managed_node_groups = {
    one = {
      name = "node-group-1"

      instance_types = ["t3.medium"]

      min_size     = 1
      max_size     = 1
      desired_size = 1
    }
  }
}

resource "aws_db_instance" "rds-mssql" {
  engine         = "sqlserver-ex"
  engine_version = "15.00"
  instance_class = "db.t3.micro"
  identifier     = "mydb"
  username       = "dbuser"
  password       = "dbpassword"

  allocated_storage     = 20
  storage_type = "gp2" 

  port = 1433

  skip_final_snapshot = true
  publicly_accessible = true
  multi_az            = false
}

resource "aws_security_group" "rds_sg" {
  name_prefix = "rds-"

  vpc_id = module.vpc.vpc_id

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