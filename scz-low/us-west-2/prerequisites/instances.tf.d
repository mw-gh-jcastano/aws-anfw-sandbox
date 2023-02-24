resource "aws_instance" "spoke_vpc_a_host" {
  depends_on = [aws_iam_instance_profile.instance_profile]
  ami                    = data.aws_ami.amazon-linux-2.id
  subnet_id              = aws_subnet.spoke_vpc_a_protected_subnet[0].id
  iam_instance_profile   = aws_iam_instance_profile.instance_profile.name
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.spoke_vpc_a_host_sg.id]

  tags          = merge(var.tags,
    {
      Name = "spoke-vpc-a/host"
    },
  )
  user_data = file("install-nginx.sh")
}

resource "aws_instance" "spoke_vpc_b_host" {
  depends_on = [aws_iam_instance_profile.instance_profile]
  ami                    = data.aws_ami.amazon-linux-2.id
  subnet_id              = aws_subnet.spoke_vpc_b_protected_subnet[0].id
  iam_instance_profile   = aws_iam_instance_profile.instance_profile.name
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.spoke_vpc_b_host_sg.id]
  tags          = merge(var.tags,
    {
      Name = "spoke-vpc-b/host"
    },
  )
  user_data = file("install-nginx.sh")
}

resource "aws_instance" "shared_svcs_vpc_host" {
  depends_on = [aws_iam_instance_profile.instance_profile]
  ami                    = data.aws_ami.amazon-linux-2.id
  subnet_id              = aws_subnet.shared-svcs_vpc_protected_subnet[0].id
  iam_instance_profile   = aws_iam_instance_profile.instance_profile.name
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.shared-svcs_vpc_host_sg.id]
  tags          = merge(var.tags,
    {
      Name = "shared-svcs-vpc/host"
    },
  )
  user_data = file("install-nginx.sh")
}

output "shared-svcs_vpc_host_ip" {
  value = aws_instance.shared_svcs_vpc_host.private_ip
}

output "spoke_vpc_a_host_ip" {
  value = aws_instance.spoke_vpc_a_host.private_ip
}

output "spoke_vpc_b_host_ip" {
  value = aws_instance.spoke_vpc_b_host.private_ip
}
