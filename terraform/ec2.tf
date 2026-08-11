resource "aws_instance" "my_ec2" {
    for_each = toset(["dev"])
    ami = data.aws_ssm_parameter.ubuntu.value
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.web_sg.id]

    user_data = <<-EOF
                #! /bin/bash
                apt update -y
                apt install nginx -y
                systemctl start nginx
                systemctl enable nginx
                EOF


    tags = {
        Name = "${var.instance_name}-${each.key}"
    }
}

