output "inspection_vpc_id" {
  value = module.inspection_vpc.vpc_id
}

output "firewall_subnets" {
  value = module.inspection_vpc.firewall_cidr_block
}