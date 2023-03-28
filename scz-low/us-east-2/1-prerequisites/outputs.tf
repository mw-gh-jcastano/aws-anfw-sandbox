output "transit_gateway_id" {
  value = module.prerequisites.transit_gateway_id
}

output "spoke_vpc_a_id" {
  value = module.prerequisites.spoke_vpc_a_id
}

output "spoke_vpc_b_id" {
  value = module.prerequisites.spoke_vpc_b_id
}

output "tgw_attachment_spoke_vpc_a_id" {
  value = module.prerequisites.tgw_attachment_spoke_vpc_a_id
}

output "tgw_attachment_spoke_vpc_b_id" {
  value = module.prerequisites.tgw_attachment_spoke_vpc_b_id
}

#output "tgw_attachment_ids" {
#  value = module.prerequisites.tgw_attachment_ids
#}

output "spoke_vpc_a_cidr" {
  value = module.prerequisites.spoke_vpc_a_cidr
}

output "spoke_vpc_b_cidr" {
  value = module.prerequisites.spoke_vpc_b_cidr
}
