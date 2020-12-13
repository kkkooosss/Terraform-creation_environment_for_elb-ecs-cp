resource "aws_ecs_task_definition" "elb-autoscalle-task-definition" {
  family = "elb-autoscalle-task-definition"
  container_definitions = <<EOF
  [
    {
      "name": "alb-scale-cont",
      "image": "alb-http-ecs:00000",
      "cpu" : 512,
      "memory": 256,
      "essential": true, 
      "portMappings": [
        {
          "hostPort": 80,
          "protocol": "tcp",
          "containerPort": 80
        }
      ]
    }
  ]    
EOF
}

resource "aws_ecs_service" "elb-auto-scale-service" {
  name            = "elb-auto-scale-service"
  cluster         = aws_ecs_cluster.my-alb-ec2-cluster.id
  task_definition = aws_ecs_task_definition.elb-autoscalle-task-definition.arn
  desired_count   = 1
  iam_role        = aws_iam_role.ecs-service-role.arn
  depends_on      = [aws_iam_role.elb-ecs-exec-role]

  load_balancer {
    elb_name       = aws_elb.elb-ecs-cp.name
    container_name = "alb-scale-cont"
    container_port = 80
  }
  lifecycle {
    ignore_changes = [task_definition]
  }
}

