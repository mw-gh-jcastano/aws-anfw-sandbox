terraform {
  backend "s3" {
    bucket  = "s3-anfw-scz-low-us-west-2"
    key     = "aws-anfw-module-prerequisite_scz-low_us-west-2.tfstate"
    region  = "us-west-2"
    profile = "mw-occ"
  }
}