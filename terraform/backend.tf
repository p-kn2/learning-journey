terraform {
    backend "s3" {  
        bucket = "learning-journey-terraform-state"
        key    = "terraform.tfstate"
        region = "us-east-1"
        use_lockfile = true
    }
}