module "alb" {
  source                 = "../../Modules/alb/v0"
  lb_name                = "${var.project_name}-${var.env}-${var.lb_name}"
  subnets                = var.subnets
  security_groups        = var.security_groups
  project_name           = var.project_name
  env                    = var.env
  target_group_name      = var.target_group_name
  target_group_port      = var.target_group_port
  target_group_protocol  = var.target_group_protocol
  vpc_id                 = var.vpc_id
  health_check_path      = var.health_check_path
  listener_port          = var.listener_port
  listener_protocol      = var.listener_protocol  

  instance_type    = var.instance_type
  key_name         = var.key_name
  ami_id           = var.ami_id

  desired_capacity = var.desired_capacity
  min_size         = var.min_size
  max_size         = var.max_size

  asg_subnets      = var.asg_subnets


}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

