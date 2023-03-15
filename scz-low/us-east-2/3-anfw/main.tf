#########################################################################################
## AWS Network Firewall (ANFW) Creation
#########################################################################################
module "network_firewall" {
  source = "git::ssh://github.com:/mw-gh-jcastano/aws-anfw-module.git//modules/network_firewall?ref=castano-dev-routing"
  #  version = "0.0.1"

  anfw_enabled = var.anfw_enabled
  #  anfw_number   = "1"
  vpc_id       = "vpc-04005faaa2362c026"
  vpc_name     = "inspection"
  account_name = "John-Castano"
  region       = "us-east-2"

  // Tech-Debt:  Programatically fetching the Firewall subnet ID's has not been a problem, having this main.tf ANFW calling TFE code to accept this
  // has been an issue.  This tech debt of harding the firewall subnets is known and accepted for remediation at a later date.
  subnet_mapping = [
    "subnet-038b8ba36baeaa8f9", "subnet-0e17e78fdb9ddc6c7", "subnet-027381806cdd852c8"
  ]

  fivetuple_stateful_rule_group = [
    {
      capacity    = 100
      name        = "stateful"
      description = "Stateful rule example1 with 5 tuple option"
      rule_config = [{
        description           = "Pass All Rule"
        protocol              = "TCP"
        source_ipaddress      = "10.101.0.0/16"
        source_port           = 443
        destination_ipaddress = "10.102.0.0/16"
        destination_port      = 443
        direction             = "any"
        sid                   = 1
        actions = {
          type = "pass"
        }
      }]
    },
  ]

  # Stateless Rule Group
  stateless_rule_group = [
    {
      capacity    = 100
      name        = "stateless"
      description = "Stateless rule example1"
      rule_config = [{
        priority              = 1
        protocols_number      = [6]
        source_ipaddress      = "10.101.0.0/16"
        source_from_port      = 443
        source_to_port        = 443
        destination_ipaddress = "10.102.0.0/16"
        destination_from_port = 443
        destination_to_port   = 443
        tcp_flag = {
          flags = ["SYN"]
          masks = ["SYN", "ACK"]
        }
        actions = {
          type = "pass"
        }
      }]
  }]

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

########################################################################################
//BEGIN NETWORK ANFW RESOURCES
########################################################################################
#resource "aws_route" "inspection_vpc_tgw_rt_route" {
##  count                  = length(module.inspection_vpc.private_route_table_ids)
#  count                  = length(data.terraform_remote_state.inspection_vpc_tfstate.outputs.inspection_vpc_tgw_att_subnet_route_table_ids)
##  route_table_id         = element(module.inspection_vpc.private_route_table_ids, count.index)
##  route_table_id         = element(data.terraform_remote_state.inspection_vpc_tfstate.inspection_vpc_tgw_att_subnet_route_table_ids, count.index)
#  route_table_id         = element(data.terraform_remote_state.inspection_vpc_tfstate.outputs.inspection_vpc_tgw_att_subnet_route_table_ids, count.index)
##  vpc_endpoint_id        = (aws_networkfirewall_firewall.nfw.firewall_status[0].sync_states[*].attachment[0].endpoint_id)[count.index]
##  vpc_endpoint_id        = (module.network_firewall.firewall_status[0].sync_states[*].attachment[0].endpoint_id)[count.index]
#  vpc_endpoint_id        = module.network_firewall.firewall.
#  destination_cidr_block = "0.0.0.0/0"
#
#  depends_on = [
###    aws_networkfirewall_firewall.nfw
#    module.network_firewall
#  ]
#}
