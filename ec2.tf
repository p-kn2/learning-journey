resource "aws_instance" "my_ec2" {
    ami = data.aws_ssm_parameter.ubuntu.value
    instance_type = var.instance_type

    tags = {
        Name = var.instance_name
    }
}

