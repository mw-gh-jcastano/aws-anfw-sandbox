module "inspection_vpc" {
  source                               = "git::ssh://github.com:/mw-gh-jcastano/aws-anfw-module.git//modules/inspection_vpc?ref=castano-dev-routing"
  #  version                           = "> 0"

  cloud_logs_enabled                   = true

  #  account_name                      = data.aws_caller_identity.current.account.id
  account_name                         = "John-Castano"
  #  flow_iam_role_arn                 = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/flow-logs-role"
  #  region                            = data.aws_region_current.name
  region                               = "us-east-2"

// TECH-DEBT: CHANGE CIDR TO 10.101.0.0/20
  vpc_cidr_block                       = "10.101.1.0/24"
  subnet_size_bits                     = 4
  vpc_name                             = "inspection_vpc"
  #  transit_gateway_id                 = data.consul_keys.tgw_1.var.id
  transit_gateway_id                   = "tgw-0ac31871d992ce04f"

// TECH-DEBT BEGIN: PROGRAMATICALLY FETCH VALUES FROM PREREQUISITES OUTPUTS
#  transit_gateway_workload_attachments = "tgw-attach-0746b7e8255207f48"

  spoke_vpc_a_cidr                     = "10.101.32.0/20"
  tgw_attachment_spoke_vpc_a           = "tgw-attach-00930a28c87e94dc3"

  spoke_vpc_b_cidr                     = "10.101.48.0/20"
  tgw_attachment_spoke_vpc_b           = "tgw-attach-0df2cc9a7f9ae033b"
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