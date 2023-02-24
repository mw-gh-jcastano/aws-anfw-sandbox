resource "aws_vpc_endpoint" "scz-low_spoke_vpc_a_ssm_endpoint" {
  vpc_id            = aws_vpc.scz-low_spoke_vpc_a.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ssm"
  vpc_endpoint_type = "Interface"
  subnet_ids        = aws_subnet.scz-low_spoke_vpc_a_endpoint_subnet[*].id
  security_group_ids = [
    aws_security_group.scz-low_spoke_vpc_a_endpoint_sg.id,
  ]
  private_dns_enabled = true

  tags          = merge(var.tags,
    {
      Name = "scz-low_spoke-vpc-a/ssm-ec2-endpoints"
    },
  )
}

resource "aws_vpc_endpoint" "scz-low_spoke_vpc_a_ssm_messages_endpoint" {
  vpc_id            = aws_vpc.scz-low_spoke_vpc_a.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ssmmessages"
  vpc_endpoint_type = "Interface"
  subnet_ids        = aws_subnet.scz-low_spoke_vpc_a_endpoint_subnet[*].id
  security_group_ids = [
    aws_security_group.scz-low_spoke_vpc_a_endpoint_sg.id,
  ]
  private_dns_enabled = true

  tags          = merge(var.tags,
    {
      Name = "scz-low_spoke-vpc-a/vpc-ssm-messages-endpoints"
    },
  )
}

resource "aws_vpc_endpoint" "scz-low_spoke_vpc_a_ec2_messages_endpoint" {
  vpc_id            = aws_vpc.scz-low_spoke_vpc_a.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ec2messages"
  vpc_endpoint_type = "Interface"
  subnet_ids        = aws_subnet.scz-low_spoke_vpc_a_endpoint_subnet[*].id
  security_group_ids = [
    aws_security_group.scz-low_spoke_vpc_a_endpoint_sg.id,
  ]
  private_dns_enabled = true

  tags          = merge(var.tags,
    {
      Name = "scz-low_spoke-vpc-a/vpc-ec2-messages-endpoints"
    },
  )
}

resource "aws_vpc_endpoint" "scz-low_spoke_vpc_b_ssm_endpoint" {
  vpc_id            = aws_vpc.scz-low_spoke_vpc_b.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ssm"
  vpc_endpoint_type = "Interface"
  subnet_ids        = aws_subnet.scz-low_spoke_vpc_b_endpoint_subnet[*].id
  security_group_ids = [
    aws_security_group.scz-low_spoke_vpc_b_endpoint_sg.id,
  ]
  private_dns_enabled = true

  tags          = merge(var.tags,
    {
      Name = "scz-low_spoke-vpc-b/vpc-ssm-endpoints"
    },
  )
}

resource "aws_vpc_endpoint" "scz-low_spoke_vpc_b_ssm_messages_endpoint" {
  vpc_id            = aws_vpc.scz-low_spoke_vpc_b.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ssmmessages"
  vpc_endpoint_type = "Interface"
  subnet_ids        = aws_subnet.scz-low_spoke_vpc_b_endpoint_subnet[*].id
  security_group_ids = [
    aws_security_group.scz-low_spoke_vpc_b_endpoint_sg.id,
  ]
  private_dns_enabled = true

  tags          = merge(var.tags,
    {
      Name = "scz-low_spoke-vpc-b/vpc-ssm-messages-endpoints"
    },
  )
}

resource "aws_vpc_endpoint" "scz-low_spoke_vpc_b_ec2_messages_endpoint" {
  vpc_id            = aws_vpc.scz-low_spoke_vpc_b.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ec2messages"
  vpc_endpoint_type = "Interface"
  subnet_ids        = aws_subnet.scz-low_spoke_vpc_b_endpoint_subnet[*].id
  security_group_ids = [
    aws_security_group.scz-low_spoke_vpc_b_endpoint_sg.id,
  ]
  private_dns_enabled = true

  tags          = merge(var.tags,
    {
      Name = "scz-low_spoke-vpc-b/vpc-ec2-messages-endpoints"
    },
  )
}