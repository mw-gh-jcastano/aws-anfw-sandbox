variable "super_cidr_block" {
  type    = string
  default = "10.101.0.0/16"
}

variable "security_zone" {
  description = "Level of the Security Zone, example: scz-low, scz-high"
  type = string
}

variable "region" {
  description = "The region for this VPC"
  type        = string
}

locals {
  // The 1st /20 in 10.10x.0.0/16
#  edge_vpc_cidr = cidrsubnet(var.super_cidr_block, 4, 0)
  // The 2nd /20 in 10.10x.0.0/16
#  shared-svcs_vpc_cidr = cidrsubnet(var.super_cidr_block, 4, 1)
  // The 3rd /20 in 10.10x.0.0/16
  spoke_vpc_a_cidr    = cidrsubnet(var.super_cidr_block, 4, 2)
  // The 4th /20 in 10.10x.0.0/16
  spoke_vpc_b_cidr    = cidrsubnet(var.super_cidr_block, 4, 3)
#  inspection_vpc_cidr    = cidrsubnet(var.super_cidr_block, 8, 253)
#  ctrl_pln_vpc_cidr = cidrsubnet(var.super_cidr_block, 8, 254)
}

variable "tags" {
  type        = map(string)
  description = "Map of tags to put on the resource"
  default     = {}
}

#variable "az_ids" {
#  description = "List of Availability Zone Identifiers.  default is \"a\",\"b\",\"c\""
#  type = list(string)
#  default = ["a", "b", "c"]
#}

#variable "fivetuple_stateful_rule_group" {
#  description = "Config for 5-tuple type stateful rule group"
#  type        = list(any)
#  default     = []
#}

#variable "domain_stateful_rule_group" {
#  description = "Config for domain type stateful rule group"
#  type        = list(any)
#  default     = []
#}

#variable "suricata_stateful_rule_group" {
#  description = "Config for Suricata type stateful rule group"
#  type        = list(any)
#  default     = []
#}

#variable "stateless_rule_group" {
#  description = "Config for stateless rule group"
#  type = list(any)
#}

#variable "stateless_default_actions" {
#  description = "Default stateless Action"
#  type = string
#  default = "forward_to_sfe"
#}

#variable "stateless_fragment_default_actions" {
#  description = "Default Stateless action for fragmented packets"
#  type = string
#  default = "forward_to_sfe"
#}