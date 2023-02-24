resource "aws_vpc" "scz-low_ctrl_pln_vpc" {
  cidr_block       = local.scz-low_ctrl_pln_vpc_cidr
  instance_tenancy = "default"

  tags             = merge(var.tags,
    {
      Name         = "scz-low_ctrl_pln_vpc"
    },
  )
}

// Tasks
// Create pre-inspection route table
#resource "aws_route_table" "scz-low_ctrl_pln_vpc_pre_inspection_route_table" {
#  count  = length(data.aws_availability_zones.available.names)
#  vpc_id = aws_vpc.scz-low_ctrl_pln_vpc.id

  # Added this, not sure if it is correct
  #    route {
  #      cidr_block = "0.0.0.0/0"
  #      # https://github.com/hashicorp/terraform-provider-aws/issues/16759
  #      #vpc_endpoint_id = element([for ss in tolist(aws_networkfirewall_firewall.firewall.firewall_status[0].sync_states) : ss.attachment[0].endpoint_id if ss.attachment[0].subnet_id == aws_subnet.inspection_vpc_firewall_subnet[count.index].id], 0)
  #      transit_gateway_id = aws_ec2_transit_gateway_vpc_attachment.edge_vpc_tgw_attachment.id
  #    }

  #  route {
  #    cidr_block = "0.0.0.0/0"
  #    # https://github.com/hashicorp/terraform-provider-aws/issues/16759
  #    vpc_endpoint_id = element([for ss in tolist(aws_networkfirewall_firewall.firewall.firewall_status[0].sync_states) : ss.attachment[0].endpoint_id if ss.attachment[0].subnet_id == aws_subnet.inspection_vpc_firewall_subnet[count.index].id], 0)
  #  }

#  tags         = merge(var.tags,
#    {
#      Name = "scz-low_ctrl_pln-vpc/${data.aws_availability_zones.available.names[count.index]}/pre-inspection_route-table"
#    },
#  )
#}


// Create post-inspection route table
#resource "aws_route_table" "scz-low_ctrl_pln_vpc_post_inspection_route_table" {
#  count  = length(data.aws_availability_zones.available.names)
#  vpc_id = aws_vpc.scz-low_ctrl_pln_vpc.id

  # Added this, not sure if it is correct
  #    route {
  #      cidr_block = "0.0.0.0/0"
  #      # https://github.com/hashicorp/terraform-provider-aws/issues/16759
  #      #vpc_endpoint_id = element([for ss in tolist(aws_networkfirewall_firewall.firewall.firewall_status[0].sync_states) : ss.attachment[0].endpoint_id if ss.attachment[0].subnet_id == aws_subnet.inspection_vpc_firewall_subnet[count.index].id], 0)
  #      transit_gateway_id = aws_ec2_transit_gateway_vpc_attachment.edge_vpc_tgw_attachment.id
  #    }

  #  route {
  #    cidr_block = "0.0.0.0/0"
  #    # https://github.com/hashicorp/terraform-provider-aws/issues/16759
  #    vpc_endpoint_id = element([for ss in tolist(aws_networkfirewall_firewall.firewall.firewall_status[0].sync_states) : ss.attachment[0].endpoint_id if ss.attachment[0].subnet_id == aws_subnet.inspection_vpc_firewall_subnet[count.index].id], 0)
  #  }

#  tags         = merge(var.tags,
#    {
#      Name = "scz-low_ctrl_pln-vpc/${data.aws_availability_zones.available.names[count.index]}/post-inspection_route-table"
#    },
#  )
#}

#resource "aws_ec2_transit_gateway_route_table" "scz-low_ctrl_pln_vpc_edge_route_table" {
#  transit_gateway_id = aws_ec2_transit_gateway.scz-low_ctrl_pln_tgw.id
#
#  tags         = merge(var.tags,
#    {
#      Name = "scz-low_ctrl_pln-tgw/edge_route-table"
#    },
#  )
#}

// Create Transit Gateway attachment
# Control Plane VPC TGW Attachment CIDR Subnet, Route Table & Association
#resource "aws_subnet" "scz-low_ctrl_pln_vpc_tgw_subnet" {
#  count                   = length(data.aws_availability_zones.available.names)
#  map_public_ip_on_launch = false
#  vpc_id                  = aws_vpc.scz-low_ctrl_pln_non_priv_vpc.id
#  availability_zone       = data.aws_availability_zones.available.names[count.index]
#  cidr_block              = cidrsubnet(local.scz-low_ctrl_pln_vpc_cidr, 4, 0 + count.index)
#
#  tags         = merge(var.tags,
#    {
#      Name = "scz-low_ctrl_pln_vpc/${data.aws_availability_zones.available.names[count.index]}/tgw-subnet"
#    },
#  )
#}
#
#resource "aws_route_table" "scz-low_ctrl_pln_vpc_tgw_subnet_route_table" {
#  count  = length(data.aws_availability_zones.available.names)
#  vpc_id = aws_vpc.scz-low_ctrl_pln_non_priv_vpc.id
#
#  # Added this, not sure if it is correct
#  #    route {
#  #      cidr_block = "0.0.0.0/0"
#  #      # https://github.com/hashicorp/terraform-provider-aws/issues/16759
#  #      #vpc_endpoint_id = element([for ss in tolist(aws_networkfirewall_firewall.firewall.firewall_status[0].sync_states) : ss.attachment[0].endpoint_id if ss.attachment[0].subnet_id == aws_subnet.inspection_vpc_firewall_subnet[count.index].id], 0)
#  #      transit_gateway_id = aws_ec2_transit_gateway_vpc_attachment.edge_vpc_tgw_attachment.id
#  #    }
#
#  #  route {
#  #    cidr_block = "0.0.0.0/0"
#  #    # https://github.com/hashicorp/terraform-provider-aws/issues/16759
#  #    vpc_endpoint_id = element([for ss in tolist(aws_networkfirewall_firewall.firewall.firewall_status[0].sync_states) : ss.attachment[0].endpoint_id if ss.attachment[0].subnet_id == aws_subnet.inspection_vpc_firewall_subnet[count.index].id], 0)
#  #  }
#
#  tags         = merge(var.tags,
#    {
#      Name = "scz-low_ctrl_pln_vpc/${data.aws_availability_zones.available.names[count.index]}/tgw-subnet-route-table"
#    },
#  )
#}
#
#resource "aws_route_table_association" "scz-low_ctrl_pln_vpc_tgw_subnet_route_table_association" {
#  count          = length(data.aws_availability_zones.available.names)
#  route_table_id = aws_route_table.scz-low_ctrl_pln_vpc_tgw_subnet_route_table[count.index].id
#  subnet_id      = aws_subnet.scz-low_ctrl_pln_vpc_tgw_subnet[count.index].id
#}
