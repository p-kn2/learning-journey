# learning-journey

This repository documents my hands-on Terraform learning journey, covering core infrastructure provisioning concepts including EC2, S3, variables, outputs, data sources, remote state management, security groups, resource iteration, and EC2 bootstrapping using user data.


# Terraform Concepts Covered

## 1. Provider
Configured AWS provider and region for Terraform operations.

## 2. Variables
Used variables to make infrastructure configuration reusable and configurable.

## 3. tfvars
Stored environment-specific variable values outside the code.

## 4. Outputs
Displayed important resource information such as instance IPs and IDs.

## 5. Data Sources
Fetched existing AWS information dynamically, such as Ubuntu AMI IDs and account details.

## 6. EC2 Instance
Created and managed Amazon EC2 instances using Terraform.

## 7. S3 Bucket
Created and managed Amazon S3 buckets.

## 8. Remote Backend
Stored Terraform state remotely in an S3 bucket.

## 9. State Locking
Learned how Terraform prevents concurrent state modifications.

## 10. .gitignore
Excluded sensitive and temporary Terraform files from version control.

## 11. Security Groups
Configured inbound and outbound network access rules for EC2 instances.

## 12. Count
Created multiple resources from a single resource block.

## 13. For_Each
Created uniquely identified resources using maps and sets.

## 14. User Data
Automated EC2 instance bootstrapping and software installation during launch.

## 15. Terraform State
Learned local vs remote state storage and state management concepts.