variable "aws_region" {
    description = "Which aws region to deploy the resources"
    type = string
}

# variable "ami_id" {
#     description = "The AMI ID to use for the EC2 instance"
#     type = string
# }

variable "instance_type" {
    description = "The instance type for the EC2 instance"
    type = string
}

variable "instance_name" {
    description = "The name tag for the EC2 instance"
    type = string
}