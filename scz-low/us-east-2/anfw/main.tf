#########################################################################################
## AWS Network Firewall (ANFW) Creation
#########################################################################################
module "network_firewall" {
  source = "git::ssh://github.com:/mw-gh-jcastano/aws-anfw-module.git//modules/network_firewall"
  #  version = "0.0.1"

  anfw_enabled = var.anfw_enabled
  #  anfw_number   = "1"
  vpc_id       = "vpc-00f89315be86c3f67"
  vpc_name     = "inspection"
  account_name = "John-Castano"
  region       = "us-east-2"

  // Tech-Debt:  Programatically fetching the Firewall subnet ID's has not been a problem, having this main.tf ANFW calling TFE code to accept this
  // has been an issue.  This tech debt of harding the firewall subnets is known and accepted for remediation at a later date.
  subnet_mapping = [
    "subnet-0f5c6b6b7d76aa3e1", "subnet-06fac1ba250f5b206", "subnet-0774ad9384192e832"
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