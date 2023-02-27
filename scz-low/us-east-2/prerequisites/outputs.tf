#output "inspection_vpc_firewall_subnet_ids" {
#  value = aws_subnet.inspection_vpc_firewall_subnet[*].id
#}

output "scz-low_tgw-id" {
  value = aws_ec2_transit_gateway.transit-gateway.id
}