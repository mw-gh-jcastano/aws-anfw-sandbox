module "prerequisites" {
  source = "git::ssh://github.com:/mw-gh-jcastano/aws-anfw-module.git//modules/prerequisites?ref=castano-prerequisite-source-module"
  #  version              = "> 0"

#  cloud_logs_enabled   = true

  #  account_name         = data.aws_caller_identity.current.account.id
#  account_name         = "John-Castano"
  #  flow_iam_role_arn    = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/flow-logs-role"
  #  region               = data.aws_region_current.name


  security_zone        = "scz_low"
  region               = "us-east-2"

  super_cidr_block = "10.101.0.0/16"
//The 1st /20 in 10.10x.0.0/16
#  edge_vpc_cidr = cidrsubnet(local.super_cidr_block, 4, 0)
  // The 2nd /20 in 10.10x.0.0/16
#  shared-svcs_vpc_cidr = cidrsubnet(local.super_cidr_block, 4, 1)
  // The 3rd /20 in 10.10x.0.0/16
#  spoke_vpc_a_cidr    = cidrsubnet(module.prerequisites.super_cidr_block, 4, 2)
  // The 4th /20 in 10.10x.0.0/16
#  spoke_vpc_b_cidr    = cidrsubnet(module.prerequisites.super_cidr_block, 4, 3)
#  inspection_vpc_cidr    = cidrsubnet(local.super_cidr_block, 8, 253)
#  ctrl_pln_vpc_cidr = cidrsubnet(local.super_cidr_block, 8, 254)

#  subnet_size_bits     = 3
#  vpc_name             = "inspection_vpc"
#  transit_gateway_id   = data.consul_keys.tgw_1.var.id

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