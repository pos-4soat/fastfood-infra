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

resource "aws_ecr_repository" "ecr_user" {
  name = var.ecr_user_name

  image_tag_mutability = var.image_mutability

  encryption_configuration {
    encryption_type = var.encrypt_type
  }

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags
}

output "ecr_user_repository_url" {
  value = aws_ecr_repository.ecr_user.repository_url
}