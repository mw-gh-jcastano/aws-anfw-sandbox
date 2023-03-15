output "inspection_vpc_id" {
  value = module.inspection_vpc.vpc_id
}

output "firewall_subnets" {
  value = module.inspection_vpc.firewall_cidr_block
}

output "firewall_subnets_id" {
  value = module.inspection_vpc.firewall_subnets_id
}

output "inspection_vpc_tgw_att_subnet_route_table_ids" {
  value = module.inspection_vpc.inspection_vpc_tgw_att_subnet_route_table_ids
}