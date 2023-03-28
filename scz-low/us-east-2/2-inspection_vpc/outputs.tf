output "inspection_vpc_id" {
  value = module.inspection_vpc.vpc_id
}

output "firewall_subnets" {
  value = module.inspection_vpc.firewall_cidr_block
}

output "firewall_subnets_id" {
  value = module.inspection_vpc.firewall_subnets_id
}

output "inspection_vpc_firewall_subnet_route_table_ids" {
  value = module.inspection_vpc.inspection_vpc_firewall_subnet_route_table_ids
}

output "inspection_vpc_tgw_subnet_route_table_ids" {
  value = module.inspection_vpc.inspection_vpc_tgw_subnet_route_table_ids
}

#output "transit_gateway_workload_attachment_ids" {
#  value = module.inspection_vpc.tgw_attachment_ids
#}