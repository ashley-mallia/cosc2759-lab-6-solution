provider aws {
  region  = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "sdo-lecture-terraform-state-bucket"
    key    = "lecture-5/demo-tfstate-full-app"
    region  = "us-east-1"
  }
}

