output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "region" {
  value = data.aws_region.current.region
}

output "azs" {
  value = data.aws_availability_zones.available.names
}

output "default_vpc_id" {
  value = data.aws_vpc.default.id
}

output "public_ip" {  
  value = {
    for k, v in aws_instance.my_ec2 :
    k => v.public_ip
  }
}