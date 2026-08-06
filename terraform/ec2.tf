resource "aws_instance" "my_ec2" {
    ami = data.aws_ssm_parameter.ubuntu.value
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.web_sg.id]


    tags = {
        Name = var.instance_name
    }
}

