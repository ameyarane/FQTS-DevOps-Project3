  ami                    = "ami-0f64121fa59598bf7"
    instance_type          = "t2.micro"
    vpc_security_group_ids = ["sg-0fc76108e42f52851"]
    key_name               = "fqts-demo-key"
    project_name           = "project-3"
    env                    = "stage"
    unique_ids             = ["jenkins-ec2"]
    iam_instance_profile   = "Project3-role"