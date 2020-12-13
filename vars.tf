variable "AWS_REGION" {
  default = "eu-central-1"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "ecs-key"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "ecs-key.pub"
}

variable "ECS_INSTANCE_TYPE" {
  default = "t2.micro"
}

variable "ECS_AMIS" {
  type = map(string)
  default = {
    eu-central-1 ="ami-09e7549e8fc2233b9"
  }
}
