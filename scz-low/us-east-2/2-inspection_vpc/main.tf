module "inspection_vpc" {
  source = "git::ssh://github.com:/mw-gh-jcastano/aws-anfw-module.git//modules/inspection_vpc"
#  version              = "> 0"

  cloud_logs_enabled   = true

#  account_name         = data.aws_caller_identity.current.account.id
  account_name         = "John-Castano"
#  flow_iam_role_arn    = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/flow-logs-role"
#  region               = data.aws_region_current.name
  region               = "us-east-2"

  vpc_cidr_block       = "10.101.102.128/25"
  subnet_size_bits     = 3
  vpc_name             = "inspection_vpc"
#  transit_gateway_id   = data.consul_keys.tgw_1.var.id
  transit_gateway_id   = "tgw-0eee82a577dcc4a5c"

  cost_tracking_tags   = {
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