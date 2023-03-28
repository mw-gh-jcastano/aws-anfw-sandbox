data "aws_availability_zones" "available" {
  state = "available"
}

data "terraform_remote_state" "inspection_vpc_tfstate" {
  backend = "s3"

  config = {
    bucket  = "s3-anfw-scz-low-us-east-2"
    key     = "aws-anfw-module-scz-low_us-east-2_inspection_vpc.tfstate"
    region  = "us-east-2"
    profile = "mw-occ"
  }
}

data "terraform_remote_state" "prerequsites_tfstate" {
  backend = "s3"

  config = {
    bucket  = "s3-anfw-scz-low-us-east-2"
    key     = "aws-anfw-module-scz-low_us-east-2_prerequisite-root-module.tfstate"
    region  = "us-east-2"
    profile = "mw-occ"
  }
}