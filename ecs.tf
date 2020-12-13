

# cluster
resource "aws_ecs_cluster" "my-alb-ec2-cluster" {
  name = "my-alb-ec2-cluster"
}

resource "aws_launch_configuration" "my-alb-ec2-launchconfig" {
  name_prefix          = "my-alb-ec2-launchconfig"
  image_id             = var.ECS_AMIS[var.AWS_REGION]
  instance_type        = var.ECS_INSTANCE_TYPE
  key_name             = aws_key_pair.ecs-key.key_name
  iam_instance_profile = aws_iam_instance_profile.elb-ecs-exec-role.id
  security_groups      = [aws_security_group.http-ssh-sg.id]
  user_data            = "#!/bin/bash\n echo 'ECS_CLUSTER=my-alb-ec2-cluster' >> /etc/ecs/ecs.config\n start ecs"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "elb-ecs-cp-asg" {
  name                 = "elb-ecs-cp-asg"
  launch_configuration = aws_launch_configuration.my-alb-ec2-launchconfig.name
  availability_zones = ["eu-central-1b", "eu-central-1a", "eu-central-1c"]
  min_size             = 2
  max_size             = 2
  tag {
    key                 = "Name"
    value               = "elb-ecs-cp"
    propagate_at_launch = true
  }
}
resource "aws_autoscaling_attachment" "elb-ecs-cp-asg" {
  autoscaling_group_name = aws_autoscaling_group.elb-ecs-cp-asg.id
  elb                    = aws_elb.elb-ecs-cp.id
}

resource "aws_elb" "elb-ecs-cp" {
  name = "elb-ecs-cp"
  availability_zones = ["eu-central-1b", "eu-central-1a", "eu-central-1c"]
 
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 300
  connection_draining         = true
  connection_draining_timeout = 300
  security_groups = [aws_security_group.http-ssh-sg.id]
  
  tags = {
    Name = "elb-ecs-cp"
  }
}

