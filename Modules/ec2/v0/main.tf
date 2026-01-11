resource "aws_instance" "myec2" {
    ami                    = var.ami
    instance_type          = var.instance_type
    vpc_security_group_ids = var.vpc_security_group_ids 
    key_name               = var.key_name
    user_data              = var.user_data
    iam_instance_profile   = var.iam_instance_profile
    tags = {
        Name = "${var.company_name}-${var.name}"
        company_name = var.company_name
        project_name = var.project_name
        env = var.env
    }
}