#output "inspection_vpc_firewall_subnet_ids" {
#  value = aws_subnet.scz-low_inspection_vpc_firewall_subnet[*].id
#}
#
#output "inspection_vpc_id" {
#  value = aws_vpc.scz-low_inspection_vpc[*].id
#}

output "scz-low_tgw-id" {
  value = aws_ec2_transit_gateway.scz-low_ctrl_pln_tgw.id
}