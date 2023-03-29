########################################################################################
// BEGIN BASIC AWS NETWORK FIREWALL (ANFW) RESOURCES
########################################################################################
module "network_firewall" {
#  source = "git::ssh://github.com:/mw-gh-jcastano/aws-anfw-module.git//modules/network_firewall"
  source = "git::ssh://github.com:/mw-gh-jcastano/aws-anfw-module.git//modules/network_firewall?ref=source-module-routing"
  #  version = "0.0.1"

  anfw_enabled = var.anfw_enabled
  #  anfw_number   = "1"
  vpc_id       = "vpc-000448795fb41e322"
  vpc_name     = "inspection"
  account_name = "John-Castano"
  region       = "us-east-2"

  // TECH-DEBT:  Programatically fetching the Firewall subnet ID's has not been a problem, having this main.tf ANFW calling TFE code to accept this
  // has been an issue.  This tech debt of han1ding the firewall subnets is known and accepted for remediation at a later date.
  subnet_mapping = [
    "subnet-0b35303a524f58328", "subnet-0e7781afe96b29cc5", "subnet-033607b8b89586863"
  ]

  // TECH-DEBT:  Need to scale the rules from the root modult into seperate .tf files for greater human friendly organization
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
  count                  = length(data.terraform_remote_state.inspection_vpc_tfstate.outputs.inspection_vpc_tgw_subnet_route_table_ids)
  route_table_id         = element(data.terraform_remote_state.inspection_vpc_tfstate.outputs.inspection_vpc_tgw_subnet_route_table_ids, count.index)
  // TECH-DEBT:  bring to standard the local.azs code block with how the rest of the modules build across availability zones.  See locals.tf for more information.
  vpc_endpoint_id        = lookup(module.network_firewall.endpoint_id_az, local.azs[count.index])
  destination_cidr_block = "0.0.0.0/0"

  depends_on = [
    module.network_firewall
  ]
}