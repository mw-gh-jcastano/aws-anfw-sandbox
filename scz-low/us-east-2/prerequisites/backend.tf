terraform {
  backend "s3" {
    bucket  = "s3-anfw-scz-low-us-east-2"
    key     = "aws-anfw-module-prerequisite_scz-low_us-east-2.tfstate"
    region  = "us-east-2"
    profile = "mw-occ"
  }
}