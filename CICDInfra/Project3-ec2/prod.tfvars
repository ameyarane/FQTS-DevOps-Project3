  ami                    = "ami-0f64121fa59598bf7"
    instance_type          = "t2.micro"
    vpc_security_group_ids = ["sg-07dde94cd9274dec7"]
    key_name               = "fqts-demo-key"
    project_name           = "project-3"
    env                    = "prod"
    unique_ids             = ["jenkins-prod"]
    iam_instance_profile   = "Project3-role"