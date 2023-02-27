locals {
  region           = "us-west-2"
  security_zone    = "scz_low"
 // NETWORKING
  super_cidr_block = "10.102.0.0/16"
  // The 1st /20 in 10.10x.0.0/16
  #  edge_vpc_cidr = cidrsubnet(local.super_cidr_block, 4, 0)
  // The 2nd /20 in 10.10x.0.0/16
  #  shared-svcs_vpc_cidr = cidrsubnet(local.super_cidr_block, 4, 1)
  // The 3rd /20 in 10.10x.0.0/16
  spoke_vpc_a_cidr    = cidrsubnet(local.super_cidr_block, 4, 2)
  // The 4th /20 in 10.10x.0.0/16
  spoke_vpc_b_cidr    = cidrsubnet(local.super_cidr_block, 4, 3)
  #  inspection_vpc_cidr    = cidrsubnet(local.super_cidr_block, 8, 253)
  #  ctrl_pln_vpc_cidr = cidrsubnet(local.super_cidr_block, 8, 254)
}