terraform {
  backend "s3" {
    bucket  = "s3-anfw-scz-low-us-east-2"
    key     = "aws-anfw-module-scz-low_us-east-2_anfw.tfstate"
    region  = "us-east-2"
    profile = "mw-occ"
  }
}