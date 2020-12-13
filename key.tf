resource "aws_key_pair" "ecs-key" {
  key_name   = "ecs-key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
  lifecycle {
    ignore_changes = [public_key]
  }
}

