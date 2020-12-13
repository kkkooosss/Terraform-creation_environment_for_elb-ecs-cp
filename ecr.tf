
resource "aws_ecr_repository" "alb-http-ecs" {
  name                 = "alb-http-ecs"
  image_tag_mutability = "MUTABLE"
  }
