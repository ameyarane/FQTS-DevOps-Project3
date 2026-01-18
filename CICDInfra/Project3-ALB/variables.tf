variable "lb_name" {}
variable "subnets" { type = list(string) }
variable "security_groups" { type = list(string) }
variable "project_name" {}
variable "env" {}
variable "target_group_name" {}
variable "target_group_port" { type = number }
variable "target_group_protocol" {}
variable "vpc_id" {}
variable "health_check_path" {}
variable "listener_port" { type = number }
variable "listener_protocol" {}
