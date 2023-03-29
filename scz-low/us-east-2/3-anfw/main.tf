########################################################################################
// BEGIN BASIC AWS NETWORK FIREWALL (ANFW) RESOURCES
########################################################################################
module "network_firewall" {
#  source = "git::ssh://github.com:/mw-gh-jcastano/aws-anfw-module.git//modules/network_firewall"
  source = "git::ssh://github.com:/mw-gh-jcastano/aws-anfw-module.git//modules/network_firewall?ref=source-module-routing"
  #  version = "0.0.1"

  anfw_enabled = var.anfw_enabled
  #  anfw_number   = "1"
  vpc_id       = "vpc-0c81964a68fddb2ae"
  vpc_name     = "inspection"
  account_name = "John-Castano"
  region       = "us-east-2"

  // Tech-Debt:  Programatically fetching the Firewall subnet ID's has not been a problem, having this main.tf ANFW calling TFE code to accept this
  // has been an issue.  This tech debt of han1ding the firewall subnets is known and accepted for remediation at a later date.
  subnet_mapping = [
    "subnet-0b3e81a04474cad27", "subnet-09fbf875a4e21f8c6", "subnet-02a235faef276d227"
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
        source_port           = 80
        destination_ipaddress = "10.102.0.0/16"
        destination_port      = 80
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
        source_from_port      = 80
        source_to_port        = 80
        destination_ipaddress = "10.102.0.0/16"
        destination_from_port = 80
        destination_to_port   = 80
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

##########################################################################################
// BEGIN NETWORK FIREWALL INSPECTION VPC ROUTING RESOURCES
// TECH-DEBT:  THIS SHOULD BE MOVED INTO THE SOURCE MODULE, HOWEVER THE
##########################################################################################
resource "aws_route" "inspection_vpc_tgw_rt_route" {
#  count                  = length(module.inspection_vpc.private_route_table_ids)
  count                  = length(data.terraform_remote_state.inspection_vpc_tfstate.outputs.inspection_vpc_tgw_subnet_route_table_ids)
#  route_table_id         = element(module.inspection_vpc.private_route_table_ids, count.index)
#  route_table_id         = element(data.terraform_remote_state.inspection_vpc_tfstate.inspection_vpc_tgw_att_subnet_route_table_ids, count.index)
  route_table_id         = element(data.terraform_remote_state.inspection_vpc_tfstate.outputs.inspection_vpc_tgw_subnet_route_table_ids, count.index)
#  vpc_endpoint_id        = (aws_networkfirewall_firewall.nfw.firewall_status[0].sync_states[*].attachment[0].endpoint_id)[count.index]
#  vpc_endpoint_id        = (module.network_firewall.firewall_status[0].sync_states[*].attachment[0].endpoint_id)[count.index]
#  vpc_endpoint_id        =  element([for ss in tolist(module.network_firewall.firewall_status[0].sync_states) : ss.attachment[0].endpoint_id if ss.attachment[0].subnet_id == data.terraform_remote_state.inspection_vpc_tfstate.outputs.firewall_subnets_id[count.index].id], 0)
  // TECH-DEBT:  bring to standard the local.azs code block with how the rest of the modules build across availability zones.  See locals.tf for more information.  See locals.tf for more information
  vpc_endpoint_id        = lookup(module.network_firewall.endpoint_id_az, local.azs[count.index])
  destination_cidr_block = "0.0.0.0/0"

  depends_on = [
    module.network_firewall
  ]
}