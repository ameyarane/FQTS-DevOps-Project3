variable "lb_name"              { type = string }
variable "company_name"         { 
                                    type = string 
                                    default= "FQTS"
                                }
variable "subnets"              { type = list(string) }
variable "security_groups"      { type = list(string) }
variable "project_name"         { type = string }
variable "env"                  { type = string }
variable "target_group_name"    { type = string }
variable "target_group_port"    { type = number }
variable "target_group_protocol"{ type = string }
variable "vpc_id"               { type = string }
variable "health_check_path"    { type = string }
variable "listener_port"        { type = number }
variable "listener_protocol"    { type = string }


variable "instance_type" { type = string }
variable "key_name" { type = string }
variable "ami_id" { type = string }

variable "desired_capacity" { type = number }
variable "min_size" { type = number }
variable "max_size" { type = number }

variable "asg_subnets" { type = list(string) }
