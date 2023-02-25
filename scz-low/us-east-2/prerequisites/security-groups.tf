#resource "aws_security_group" "spoke_vpc_a_endpoint_sg" {
resource "aws_security_group" "spoke_vpc_a_endpoint_sg" {
  name        = "spoke-vpc-a/sg-ssm-ec2-endpoints"
  description = "Allow TLS inbound traffic for SSM/EC2 endpoints"
  vpc_id      = aws_vpc.spoke_vpc_a.id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.spoke_vpc_a.cidr_block]
  }

  tags          = merge(var.tags,
    {
      Name = format("%s-%s-spoke-vpc-a/sg-ssm-ec2-endpoints", var.security_zone, var.region)
    },
  )
}

resource "aws_security_group" "spoke_vpc_a_host_sg" {
  name        = "spoke-vpc-a/sg-host"
  description = "Allow all traffic from VPCs inbound and all outbound"
  vpc_id      = aws_vpc.spoke_vpc_a.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [
      aws_vpc.spoke_vpc_a.cidr_block,
     # aws_vpc.spoke_vpc_b.cidr_block
    ]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags          = merge(var.tags,
    {
      Name      = format("%s-%s-spoke-vpc-a/sg-host", var.security_zone, var.region)
    },
  )
}

resource "aws_security_group" "spoke_vpc_b_host_sg" {
  name        = "spoke-vpc-b/sg-host"
  description = "Allow all traffic from VPCs inbound and all outbound"
  vpc_id      = aws_vpc.spoke_vpc_b.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.spoke_vpc_a.cidr_block, aws_vpc.spoke_vpc_b.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags          = merge(var.tags,
    {
      Name      = format("%s-%s-spoke-vpc-b/sg-host", var.security_zone, var.region)
    },
  )
}

resource "aws_security_group" "spoke_vpc_b_endpoint_sg" {
  name        = "spoke-vpc-b/sg-ssm-ec2-endpoints"
  description = "Allow TLS inbound traffic for SSM/EC2 endpoints"
  vpc_id      = aws_vpc.spoke_vpc_b.id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.spoke_vpc_b.cidr_block]
  }

  tags          = merge(var.tags,
    {
      Name      = format("%s-%s-spoke-vpc-b/sg-ssm-ec2-endpoints", var.security_zone, var.region)
    },
  )
}

#resource "aws_security_group" "shared-svcs_vpc_host_sg" {
#  name        = "shared-svcs-vpc/sg-host"
#  description = "Allow all traffic from VPCs inbound and all outbound"
#  vpc_id      = aws_vpc.shared-svcs_vpc.id
#
#  ingress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = [
#     # aws_vpc.spoke_vpc_a.cidr_block,
#     # aws_vpc.spoke_vpc_b.cidr_block,
#      aws_vpc.shared-svcs_vpc.cidr_block]
#  }
#
#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#
#  tags          = merge(var.tags,
#    {
#       Name      = format("%s-%s-shared-services-vpc/sg-host", var.security_zone, var.region)
##      Name      = "shared-svcs-vpc/sg-host"
#    },
#  )
#}