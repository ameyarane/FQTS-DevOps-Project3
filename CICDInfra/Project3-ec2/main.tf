module "myec2" {
    source                 = "../../Modules/ec2/v0"
    # count =  length(var.unique_ids)
    count =  1
    ami                    = var.ami
    instance_type          = var.instance_type
    vpc_security_group_ids = var.vpc_security_group_ids 
    key_name               = var.key_name
    name = "${var.project_name}-${var.unique_ids[count.index]}-${var.env}"
    project_name = var.project_name
    env = var.env
    iam_instance_profile   = var.iam_instance_profile    
}