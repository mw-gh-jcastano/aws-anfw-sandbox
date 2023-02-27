resource "aws_vpc" "shared-svcs_vpc" {
  cidr_block       = local.shared-svcs_vpc_cidr
  instance_tenancy = "default"

  tags             = merge(var.tags,
    {
#      Name = format("%s-%s-shared-services-vpc", var.security_zone, var.region)
      Name = format("%s-%s-shared-services-vpc", local.security_zone, local.region)
    },
  )
}

# Shared Services VPC Protected CIDR Subnet, Route Table & Association
resource "aws_subnet" "shared-svcs_vpc_protected_subnet" {
  count                   = length(data.aws_availability_zones.available.names)
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.shared-svcs_vpc.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = cidrsubnet(local.shared-svcs_vpc_cidr, 4, 0 + count.index)

  tags         = merge(var.tags,
    {
#      Name = format("%s-%s-shared-services-vpc/${data.aws_availability_zones.available.names[count.index]}/protected-subnet", var.security_zone, var.region)
      Name = format("%s-%s-shared-services-vpc/${data.aws_availability_zones.available.names[count.index]}/protected-subnet", local.security_zone, local.region)
    },
  )
}

resource "aws_route_table" "shared-svcs_vpc_protected_subnet_route_table" {
  count  = length(data.aws_availability_zones.available.names)
  vpc_id = aws_vpc.shared-svcs_vpc.id

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
#      Name = format("%s-%s-shared-services_vpc/${data.aws_availability_zones.available.names[count.index]}/protected-subnet-route-table", var.security_zone, var.region)
      Name = format("%s-%s-shared-services_vpc/${data.aws_availability_zones.available.names[count.index]}/protected-subnet-route-table", local.security_zone, local.region)
    },
  )
}

resource "aws_route_table_association" "shared-svcs_vpc_protected_subnet_route_table_association" {
  count          = length(data.aws_availability_zones.available.names)
  route_table_id = aws_route_table.shared-svcs_vpc_protected_subnet_route_table[count.index].id
  subnet_id      = aws_subnet.shared-svcs_vpc_protected_subnet[count.index].id
}