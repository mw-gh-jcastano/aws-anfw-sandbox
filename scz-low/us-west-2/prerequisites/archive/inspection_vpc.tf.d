resource "aws_vpc" "scz-low_inspection_vpc" {
  cidr_block       = local.scz-low_inspection_vpc_cidr
  instance_tenancy = "default"

  tags             = merge(var.tags,
    {
      Name         = "scz-low_inspection_vpc"
    },
  )
}

#// Tasks
// Create Public route table
resource "aws_route_table" "scz-low_inspection_vpc_public_route_table" {
  count  = length(data.aws_availability_zones.available.names)
  vpc_id = aws_vpc.scz-low_inspection_vpc.id

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

  tags         = merge(var.tags,
    {
      Name = "scz-low_inspection-vpc/${data.aws_availability_zones.available.names[count.index]}/public_route-table"
    },
  )
}


## ANFW Inspection VPC Firewall CIDR Subnet, Route Table & Association
resource "aws_subnet" "scz-low_inspection_vpc_firewall_subnet" {
  count                   = length(data.aws_availability_zones.available.names)
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.scz-low_inspection_vpc.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = cidrsubnet(local.scz-low_inspection_vpc_cidr, 4, 4 + count.index)

  tags         = merge(var.tags,
    {
      Name = "scz-low_inspection-vpc/${data.aws_availability_zones.available.names[count.index]}/firewall-subnet"
    },
  )
}

#resource "aws_route_table" "scz-low_inspection_vpc_firewwall_subnet_route_table" {
#  count  = length(data.aws_availability_zones.available.names)
#  vpc_id = aws_vpc.scz-low_inspection_vpc.id
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
#      Name = "scz-low_inspection-vpc/${data.aws_availability_zones.available.names[count.index]}/firewall_subnet_route-table"
#    },
#  )
#}


#resource "aws_route_table_association" "scz-low_inspection_vpc_firewall_subnet_route_table_association" {
#  count          = length(data.aws_availability_zones.available.names)
# route_table_id = aws_route_table.scz-low_inspection_vpc_firewall_subnet_route_table[count.index].id
#  subnet_id      = aws_subnet.scz-low_inspection_vpc_firewall_subnet[count.index].id
#}