resource "aws_vpc" "spoke_vpc_a" {
  cidr_block           = local.spoke_vpc_a_cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags     = merge(var.tags,
    {
#      Name = format("%s-%s-spoke-vpc-a", var.security_zone, var.region)
      Name = format("%s-%s-spoke-vpc-a", local.security_zone, local.region)
    },
  )
}

resource "aws_subnet" "spoke_vpc_a_protected_subnet" {
  count                   = length(data.aws_availability_zones.available.names)
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.spoke_vpc_a.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = cidrsubnet(local.spoke_vpc_a_cidr, 4, 0 + count.index)

  tags     = merge(var.tags,
    {
#      Name = format("%s-%s-spoke-vpc-a/${data.aws_availability_zones.available.names[count.index]}/protected-subnet", var.security_zone, var.region)
      Name = format("%s-%s-spoke-vpc-a/${data.aws_availability_zones.available.names[count.index]}/protected-subnet", local.security_zone, local.region)
    },
  )
}

resource "aws_subnet" "spoke_vpc_a_endpoint_subnet" {
  count                   = length(data.aws_availability_zones.available.names)
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.spoke_vpc_a.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = cidrsubnet(local.spoke_vpc_a_cidr, 8, 64 + count.index)

  tags     = merge(var.tags,
    {
#      Name = format("%s-%s-spoke-vpc-a/${data.aws_availability_zones.available.names[count.index]}/endpoint-subnet", var.security_zone, var.region)
      Name = format("%s-%s-spoke-vpc-a/${data.aws_availability_zones.available.names[count.index]}/endpoint-subnet", local.security_zone, local.region)
    },
  )
}


resource "aws_route_table" "spoke_vpc_a_route_table" {
  vpc_id = aws_vpc.spoke_vpc_a.id

#  route {
#    cidr_block         = "0.0.0.0/0"
#    transit_gateway_id = aws_ec2_transit_gateway.tgw.id
#  }

  tags     = merge(var.tags,
    {
#      Name = format("%s-%s-spoke-vpc-a/route-table", var.security_zone, var.region)
      Name = format("%s-%s-spoke-vpc-a/route-table", local.security_zone, local.region)
    },
  )
}

resource "aws_route_table_association" "spoke_vpc_a_route_table_association" {
  count          = length(aws_subnet.spoke_vpc_a_protected_subnet[*])
  subnet_id      = aws_subnet.spoke_vpc_a_protected_subnet[count.index].id
  route_table_id = aws_route_table.spoke_vpc_a_route_table.id
}