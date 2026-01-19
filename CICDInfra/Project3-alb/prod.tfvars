lb_name                = "alb"
subnets                = ["subnet-0445ad7f30dc49eb0","subnet-0ee3e27d41ca239d6","subnet-0ce83831e3900e1ed"]
security_groups        = ["sg-07dde94cd9274dec7"]
project_name           = "project-3"
env                    = "prod"
target_group_name      = "prod-tg"
target_group_port      = 80
target_group_protocol  = "HTTP"
vpc_id                 = "vpc-020cdb293828a27e7"
health_check_path      = "/"
listener_port          = 80
listener_protocol      = "HTTP"

instance_type        = "t3.micro"
key_name             = "fqts-demo-key"
ami_id               = "ami-0f64121fa59598bf7"  # change to your AMI

desired_capacity     = 2
min_size             = 1
max_size             = 3

asg_subnets          = ["subnet-0445ad7f30dc49eb0","subnet-0ee3e27d41ca239d6"]