resource "aws_vpc_endpoint" "spoke_vpc_a_ssm_endpoint" {
  vpc_id            = aws_vpc.spoke_vpc_a.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ssm"
  vpc_endpoint_type = "Interface"
  subnet_ids        = aws_subnet.spoke_vpc_a_endpoint_subnet[*].id
  security_group_ids = [
    aws_security_group.spoke_vpc_a_endpoint_sg.id,
  ]
  private_dns_enabled = true

  tags          = merge(var.tags,
    {
#      Name = format("%s-%s-spoke-vpc-a/ssm-ec2-endpoints", var.security_zone, var.region)
      Name = format("%s-%s-spoke-vpc-a/ssm-ec2-endpoints", local.security_zone, local.region)
    },
  )
}

resource "aws_vpc_endpoint" "spoke_vpc_a_ssm_messages_endpoint" {
  vpc_id            = aws_vpc.spoke_vpc_a.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ssmmessages"
  vpc_endpoint_type = "Interface"
  subnet_ids        = aws_subnet.spoke_vpc_a_endpoint_subnet[*].id
  security_group_ids = [
    aws_security_group.spoke_vpc_a_endpoint_sg.id,
  ]
  private_dns_enabled = true

  tags     = merge(var.tags,
    {
#      Name = format("%s-%s-spoke-vpc-a/ssm-messages-endpoints", var.security_zone, var.region)
      Name = format("%s-%s-spoke-vpc-a/ssm-messages-endpoints", local.security_zone, local.region)
    },
  )
}

resource "aws_vpc_endpoint" "spoke_vpc_a_ec2_messages_endpoint" {
  vpc_id            = aws_vpc.spoke_vpc_a.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ec2messages"
  vpc_endpoint_type = "Interface"
  subnet_ids        = aws_subnet.spoke_vpc_a_endpoint_subnet[*].id
  security_group_ids = [
    aws_security_group.spoke_vpc_a_endpoint_sg.id,
  ]
  private_dns_enabled = true

  tags     = merge(var.tags,
    {
#      Name = format("%s-%s-spoke-vpc-a/vpc-ec2-messages-endpoints", var.security_zone, var.region)
      Name = format("%s-%s-spoke-vpc-a/vpc-ec2-messages-endpoints", local.security_zone, local.region)
    },
  )
}

resource "aws_vpc_endpoint" "spoke_vpc_b_ssm_endpoint" {
  vpc_id            = aws_vpc.spoke_vpc_b.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ssm"
  vpc_endpoint_type = "Interface"
  subnet_ids        = aws_subnet.spoke_vpc_b_endpoint_subnet[*].id
  security_group_ids = [
    aws_security_group.spoke_vpc_b_endpoint_sg.id,
  ]
  private_dns_enabled = true

  tags     = merge(var.tags,
    {
#      Name = format("%s-%s-spoke-vpc-b/vpc-ssm-endpoints", var.security_zone, var.region)
      Name = format("%s-%s-spoke-vpc-b/vpc-ssm-endpoints", local.security_zone, local.region)
    },
  )
}

resource "aws_vpc_endpoint" "spoke_vpc_b_ssm_messages_endpoint" {
  vpc_id            = aws_vpc.spoke_vpc_b.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ssmmessages"
  vpc_endpoint_type = "Interface"
  subnet_ids        = aws_subnet.spoke_vpc_b_endpoint_subnet[*].id
  security_group_ids = [
    aws_security_group.spoke_vpc_b_endpoint_sg.id,
  ]
  private_dns_enabled = true

  tags     = merge(var.tags,
    {
#      Name = format("%s-%s-spoke-vpc-b/vpc-ssm-messages-endpoints", var.security_zone, var.region)
      Name = format("%s-%s-spoke-vpc-b/vpc-ssm-messages-endpoints", local.security_zone, local.region)
    },
  )
}

resource "aws_vpc_endpoint" "spoke_vpc_b_ec2_messages_endpoint" {
  vpc_id            = aws_vpc.spoke_vpc_b.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ec2messages"
  vpc_endpoint_type = "Interface"
  subnet_ids        = aws_subnet.spoke_vpc_b_endpoint_subnet[*].id
  security_group_ids = [
    aws_security_group.spoke_vpc_b_endpoint_sg.id,
  ]
  private_dns_enabled = true

  tags     = merge(var.tags,
    {
#      Name = format("%s-%s-spoke-vpc-b/vpc-ec2-messages-endpoints", var.security_zone, var.region)
      Name = format("%s-%s-spoke-vpc-b/vpc-ec2-messages-endpoints", local.security_zone, local.region)
    },
  )
}