resource "aws_vpc" "scz-low_edge_vpc" {
  cidr_block           = local.scz-low_edge_vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags         = merge(var.tags,
    {
      Name = "scz-low_edge-vpc"
    },
  )
}

resource "aws_subnet" "scz-low_edge_vpc_public_subnet" {
  count                   = length(data.aws_availability_zones.available.names)
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.scz-low_edge_vpc.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = cidrsubnet(local.scz-low_edge_vpc_cidr, 4, 0 + count.index)
  depends_on              = [aws_internet_gateway.scz-low_edge_vpc_igw]

  tags                    = merge(var.tags,
    {
      Name                = "scz-low_edge-vpc/${data.aws_availability_zones.available.names[count.index]}/public-subnet"
    },
  )
}

resource "aws_route_table" "scz-low_edge_vpc_public_subnet_route_table" {
  count  = length(data.aws_availability_zones.available.names)
  vpc_id = aws_vpc.scz-low_edge_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.scz-low_edge_vpc_igw.id
  }

  #    route {
  #      cidr_block = var.super_cidr_block
  #      # https://github.com/hashicorp/terraform-provider-aws/issues/16759
  #      vpc_endpoint_id = element([for ss in tolist(aws_networkfirewall_firewall.inspection_vpc_anfw.firewall_status[0].sync_states) : ss.attachment[0].endpoint_id if ss.attachment[0].subnet_id == aws_subnet.inspection_vpc_firewall_subnet[count.index].id], 0)
  #    }

  tags         = merge(var.tags,
    {
      Name = "scz-low_edge-vpc/${data.aws_availability_zones.available.names[count.index]}/public-subnet-route-table"
    },
  )
}

resource "aws_route_table_association" "scz-low_edge_vpc_public_subnet_route_table_association" {
  count          = length(data.aws_availability_zones.available.names)
  route_table_id = aws_route_table.scz-low_edge_vpc_public_subnet_route_table[count.index].id
  subnet_id      = aws_subnet.scz-low_edge_vpc_public_subnet[count.index].id
}

resource "aws_internet_gateway" "scz-low_edge_vpc_igw" {
  vpc_id = aws_vpc.scz-low_edge_vpc.id

  tags       = merge(var.tags,
    {
      Name = "scz-low_edge-vpc/internet-gateway"
    },
  )
}

resource "aws_eip" "scz-low_edge_vpc_nat_gw_eip" {
  count = length(data.aws_availability_zones.available.names)
}

resource "aws_nat_gateway" "scz-low_edge_vpc_nat_gw" {
  count         = length(data.aws_availability_zones.available.names)
  depends_on    = [aws_internet_gateway.scz-low_edge_vpc_igw, aws_subnet.scz-low_edge_vpc_public_subnet]
  allocation_id = aws_eip.scz-low_edge_vpc_nat_gw_eip[count.index].id
  subnet_id     = aws_subnet.scz-low_edge_vpc_public_subnet[count.index].id

  tags       = merge(var.tags,
    {
      Name = "scz-low_edge-vpc/${data.aws_availability_zones.available.names[count.index]}/nat-gateway"
    },
  )
}
