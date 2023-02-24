terraform {
  backend "s3" {
    bucket  = "s3-anfw-scz-low-us-west-2"
    key     = "aws-anfw-module-scz-low_us-west-2_anfw.tfstate"
    region  = "us-west-2"
    profile = "mw-occ"
  }
}