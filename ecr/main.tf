resource "aws_ecr_repository" "ecr_products" {
  name                 = var.ecr_products
  image_tag_mutability = var.image_mutability

  encryption_configuration {
    encryption_type = var.encrypt_type
  }

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags
}

resource "aws_ecr_repository" "ecr_auth" {
  name = var.ecr_auth

  image_tag_mutability = var.image_mutability

  encryption_configuration {
    encryption_type = var.encrypt_type
  }

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags
}

resource "aws_ecr_repository" "ecr_order" {
  name = var.ecr_auth

  image_tag_mutability = var.image_mutability

  encryption_configuration {
    encryption_type = var.encrypt_type
  }

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags
}

output "ecr_auth_repository_url" {
  value = aws_ecr_repository.ecr_auth.repository_url
}