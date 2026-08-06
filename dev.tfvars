# To copy variables in dev.tfvars, run the following command in the terminal.
# grep '^variable "' variables.tf | awk -F'"' '{print $2 " = \"\""}' > dev.tfvars


aws_region = "us-east-1"
# ami_id = "ami-0b6d9d3d33ba97d99"
instance_type = "t3.micro"
instance_name = "First_instance"
