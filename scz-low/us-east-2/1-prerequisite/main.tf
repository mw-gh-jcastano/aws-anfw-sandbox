module "prerequisites" {
  source = "git::ssh://github.com:/mw-gh-jcastano/aws-anfw-module.git//modules/prerequisites?ref=castano-prerequisite-source-module"
  #  version              = "> 0"

  #  cloud_logs_enabled   = true
  #  flow_iam_role_arn    = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/flow-logs-role"

  security_zone = "scz_low"
  region        = "us-east-2"
  super_cidr_block = "10.101.0.0/16"

  cost_tracking_tags = {
    BusinessDepartment = "Technology"
    Domain             = "SecOps"
    EnvironmentType    = "dev"
    ITDepartment       = "MWP CloudOps"
    CostCenter         = "123"
    ZoneGroupID        = "scz-low"
    Owner              = "John Castano"
    Terraform          = "True"
  }
}