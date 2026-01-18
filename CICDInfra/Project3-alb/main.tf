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
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}
