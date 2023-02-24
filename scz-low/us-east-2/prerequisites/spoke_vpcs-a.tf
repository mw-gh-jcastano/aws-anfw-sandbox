resource "aws_vpc" "scz-low_spoke_vpc_a" {
  cidr_block           = local.scz-low_spoke_vpc_a_cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags         = merge(var.tags,
    {
      Name = "scz-low_spoke-vpc-a"
    },
  )
}

resource "aws_subnet" "scz-low_spoke_vpc_a_protected_subnet" {
  count                   = length(data.aws_availability_zones.available.names)
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.scz-low_spoke_vpc_a.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = cidrsubnet(local.scz-low_spoke_vpc_a_cidr, 4, 0 + count.index)

  tags         = merge(var.tags,
    {
      Name = "scz-low_spoke-vpc-a/${data.aws_availability_zones.available.names[count.index]}/protected-subnet"
    },
  )
}

resource "aws_subnet" "scz-low_spoke_vpc_a_endpoint_subnet" {
  count                   = length(data.aws_availability_zones.available.names)
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.scz-low_spoke_vpc_a.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = cidrsubnet(local.scz-low_spoke_vpc_a_cidr, 8, 64 + count.index)

  tags         = merge(var.tags,
    {
      Name = "scz-low_spoke-vpc-a/${data.aws_availability_zones.available.names[count.index]}/endpoint-subnet"
    },
  )
}


resource "aws_route_table" "scz-low_spoke_vpc_a_route_table" {
  vpc_id = aws_vpc.scz-low_spoke_vpc_a.id

#  route {
#    cidr_block         = "0.0.0.0/0"
#    transit_gateway_id = aws_ec2_transit_gateway.tgw.id
#  }

  tags         = merge(var.tags,
    {
      Name = "scz-low_spoke-vpc-a/route-table"
    },
  )
}

resource "aws_route_table_association" "scz-low_spoke_vpc_a_route_table_association" {
  count          = length(aws_subnet.scz-low_spoke_vpc_a_protected_subnet[*])
  subnet_id      = aws_subnet.scz-low_spoke_vpc_a_protected_subnet[count.index].id
  route_table_id = aws_route_table.scz-low_spoke_vpc_a_route_table.id
}