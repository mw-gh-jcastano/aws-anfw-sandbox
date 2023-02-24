output "inspection_vpc_id" {
  value = module.scz-low_us-west-2_inspection_vpc.vpc_id
}

output "firewall_subnets" {
  value = module.scz-low_us-west-2_inspection_vpc.firewall_cidr_block
}