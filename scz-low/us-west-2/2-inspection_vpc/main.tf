module "inspection_vpc" {
  source                               = "git::ssh://github.com:/mw-gh-jcastano/aws-anfw-module.git//modules/inspection_vpc"
#  source                               = "git::ssh://github.com:/mw-gh-jcastano/aws-anfw-module.git//modules/inspection_vpc?ref=source-module-routing"
  #  version                           = "> 0"

  cloud_logs_enabled                   = true

  #  account_name                      = data.aws_caller_identity.current.account.id
  account_name                         = "John-Castano"
  #  flow_iam_role_arn                 = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/flow-logs-role"
  #  region                            = data.aws_region_current.name
  region                               = "us-west-2"

// TECH-DEBT: CHANGE CIDR TO 10.101.0.0/20
  vpc_cidr_block                       = "10.102.1.0/24"
  subnet_size_bits                     = 4
  vpc_name                             = "inspection_vpc"
  #  transit_gateway_id                 = data.consul_keys.tgw_1.var.id
  transit_gateway_id                   = "tgw-026fa0b561126cbe1"

// TECH-DEBT BEGIN: PROGRAMATICALLY FETCH VALUES FROM PREREQUISITES OUTPUTS
  spoke_vpc_a_cidr                     = "10.102.32.0/20"
  tgw_attachment_spoke_vpc_a           = "tgw-attach-08fe2b33ac418c3e6"

  spoke_vpc_b_cidr                     = "10.102.48.0/20"
  tgw_attachment_spoke_vpc_b           = "tgw-attach-0aa8f2e96822789f1"
// TECH-DEBT END: PROGRAMATCIALLY FETCH VALUES FROM PREREQUISITES OUTPUTS

  cost_tracking_tags      = {
    BusinessDepartment     = "Technology"
    Domain                 = "SecOps"
    EnvironmentType        = "dev"
    ITDepartment           = "MWP CloudOps"
    CostCenter             = "123"
    ZoneGroupID            = "scz-low"
    Owner                  = "John Castano"
    Terraform              = "True"
  }
}