resource "aws_ec2_transit_gateway" "scz-low_ctrl_pln_tgw" {
  tags         = merge(var.tags,
    {
      Name = "scz-low_transit-gateway"
    },
  )
}

###############################################################
############# Edge VPC TGW Attachment ############
###############################################################
#resource "aws_subnet" "scz-low_edge_vpc_tgw_subnet" {
#  count                   = length(data.aws_availability_zones.available.names)
#  map_public_ip_on_launch = false
#  vpc_id                  = aws_vpc.scz-low_edge_vpc.id
#  availability_zone       = data.aws_availability_zones.available.names[count.index]
#  cidr_block              = cidrsubnet(local.scz-low_edge_vpc_cidr, 8, 48 + count.index)
#
#  tags         = merge(var.tags,
#    {
#      Name = "scz-low_edge-vpc/${data.aws_availability_zones.available.names[count.index]}/tgw-subnet"
#    },
#  )
#}

#resource "aws_route_table" "scz-low_edge_vpc_tgw_subnet_route_table" {
#  count  = length(data.aws_availability_zones.available.names)
#  vpc_id = aws_vpc.scz-low_edge_vpc.id
#
#  #  route {
#  #    cidr_block = "0.0.0.0/0"
#  #    gateway_id = aws_internet_gateway.edge_vpc_igw.id
#  #  }
#
#  #    route {
#  #      cidr_block = var.super_cidr_block
#  #      # https://github.com/hashicorp/terraform-provider-aws/issues/16759
#  #      vpc_endpoint_id = element([for ss in tolist(aws_networkfirewall_firewall.inspection_vpc_anfw.firewall_status[0].sync_states) : ss.attachment[0].endpoint_id if ss.attachment[0].subnet_id == aws_subnet.inspection_vpc_firewall_subnet[count.index].id], 0)
#  #    }
#
#  tags         = merge(var.tags,
#    {
#      Name = "scz-low_edge-vpc/${data.aws_availability_zones.available.names[count.index]}/tgw-subnet-route-table"
#    },
#  )
#}

#resource "aws_route_table_association" "scz-low_edge_vpc_tgw_subnet_route_table_association" {
#  count          = length(data.aws_availability_zones.available.names)
#  route_table_id = aws_route_table.scz-low_edge_vpc_tgw_subnet_route_table[count.index].id
#  subnet_id      = aws_subnet.scz-low_edge_vpc_tgw_subnet[count.index].id
#}



#resource "aws_ec2_transit_gateway_vpc_attachment" "scz-low_edge_vpc_tgw_attachment" {
#  subnet_ids                                      = aws_subnet.scz-low_edge_vpc_tgw_subnet[*].id
#  transit_gateway_id                              = aws_ec2_transit_gateway.scz-low_ctrl_pln_tgw.id
#  vpc_id                                          = aws_vpc.scz-low_edge_vpc.id
#  transit_gateway_default_route_table_association = false
#// Appliance mode might only be required for TGW Attachments towards Inspection/ANFW VPC
##  appliance_mode_support                          = "enable"
#
#  tags         = merge(var.tags,
#    {
#      Name = "scz-low_edge-vpc-attachment"
#    },
#  )
#}

#resource "aws_ec2_transit_gateway_route_table_association" "scz-low_edge_vpc_tgw_attachment_rt_association" {
#  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.scz-low_edge_vpc_tgw_attachment.id
#  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.scz-low_ctrl_pln_vpc_edge_route_table.id
#}
#
#resource "aws_ec2_transit_gateway_route_table_propagation" "scz-low_ctrl_pln_route_table_propagate_edge_vpc" {
#  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.scz-low_edge_vpc_tgw_attachment.id
#  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.scz-low_ctrl_pln_vpc_edge_route_table.id
#}
#resource "aws_ec2_transit_gateway_route" "scz-low_edge_route_table_default_route" {
#  destination_cidr_block         = "0.0.0.0/0"
#  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.scz-low_edge_vpc_tgw_attachment.id
#  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.scz-low_ctrl_pln_vpc_edge_route_table.id
#}

## Not sure if this is correct
#resource "aws_ec2_transit_gateway_route_table_propagation" "edge_route_table_propagate_shared-svcs_vpc" {
#  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.shared-svcs_vpc_tgw_attachment.id
#  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.edge_route_table.id
#}


#resource "aws_ec2_transit_gateway_route" "edge_route_table_rfc1918_route" {
#  destination_cidr_block         = "10.0.0.0/8"
#  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.shared-svcs_vpc_tgw_attachment.id
#  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.edge_route_table.id
#}


###############################################################
############# Shared Services VPC TGW Attachment ############
###############################################################
## Shared Services VPC TGW Attachment CIDR Subnet, Route Table & Association
#resource "aws_subnet" "scz-low_shared-svcs_vpc_tgw_subnet" {
#  count                   = length(data.aws_availability_zones.available.names)
#  map_public_ip_on_launch = false
#  vpc_id                  = aws_vpc.scz-low_shared-svcs_vpc.id
#  availability_zone       = data.aws_availability_zones.available.names[count.index]
#  cidr_block              = cidrsubnet(local.scz-low_shared-svcs_vpc_cidr, 8, 48 + count.index)
#
#  tags         = merge(var.tags,
#    {
#      Name = "scz-low_shared-svcs_vpc/${data.aws_availability_zones.available.names[count.index]}/tgw-subnet"
#    },
#  )
#}

#resource "aws_route_table" "scz-low_shared-svcs_vpc_tgw_subnet_route_table" {
#  count  = length(data.aws_availability_zones.available.names)
#  vpc_id = aws_vpc.scz-low_shared-svcs_vpc.id

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
#
#  tags         = merge(var.tags,
#    {
#      Name = "scz-low_shared-svcs_vpc/${data.aws_availability_zones.available.names[count.index]}/tgw-subnet-route-table"
#    },
#  )
#}

#resource "aws_route_table_association" "scz-low_shared-svcs_vpc_tgw_subnet_route_table_association" {
#  count          = length(data.aws_availability_zones.available.names)
#  route_table_id = aws_route_table.scz-low_shared-svcs_vpc_tgw_subnet_route_table[count.index].id
#  subnet_id      = aws_subnet.scz-low_shared-svcs_vpc_tgw_subnet[count.index].id
#}
#
#resource "aws_ec2_transit_gateway_vpc_attachment" "scz-low_shared-svcs_vpc_tgw_attachment" {
#  subnet_ids                                      = aws_subnet.scz-low_shared-svcs_vpc_tgw_subnet[*].id
#  transit_gateway_id                              = aws_ec2_transit_gateway.scz-low_ctrl_pln_tgw.id
#  vpc_id                                          = aws_vpc.scz-low_shared-svcs_vpc.id
#  transit_gateway_default_route_table_association = false
#  // Appliance mode might only be required for TGW Attachments towards Inspection/ANFW VPC
#  //appliance_mode_support                          = "enable"
#
#  tags         = merge(var.tags,
#    {
#      Name = "shared-svcs_vpc-attachment"
#    },
#  )
#}
#
#// This might be a mistake and uneeded
#resource "aws_ec2_transit_gateway_route_table_association" "scz-low_shared-svcs_vpc_tgw_attachment_rt_association" {
#  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.scz-low_shared-svcs_vpc_tgw_attachment.id
#  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.scz-low_ctrl_pln_vpc_edge_route_table.id
#}

#resource "aws_ec2_transit_gateway_route_table_propagation" "shared-svcs_route_table_propagate_spoke_vpc_a" {
#  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.spoke_vpc_a_tgw_attachment.id
#  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.shared-svcs_route_table.id
#}

#resource "aws_ec2_transit_gateway_route_table_propagation" "shared-svcs_route_table_propagate_spoke_vpc_b" {
#  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.spoke_vpc_b_tgw_attachment.id
#  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.shared-svcs_route_table.id
#}

#resource "aws_ec2_transit_gateway_route_table_propagation" "spoke_route_table_propagate_shared-svcs_vpc" {
#  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.shared-svcs_vpc_tgw_attachment.id
#  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.spoke_route_table.id
#}




###############################################################
############# Spoke-A VPC TGW Attachment ############
###############################################################
resource "aws_subnet" "scz-low_spoke_vpc_a_tgw_subnet" {
  count                   = length(data.aws_availability_zones.available.names)
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.scz-low_spoke_vpc_a.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = cidrsubnet(local.scz-low_spoke_vpc_a_cidr, 8, 80 + count.index)

  tags         = merge(var.tags,
    {
      Name = "scz-low_spoke-vpc-a/${data.aws_availability_zones.available.names[count.index]}/tgw-subnet"
    },
  )
}

resource "aws_route_table" "scz-low_spoke_vpc_a_tgw_subnet_route_table" {
  count  = length(data.aws_availability_zones.available.names)
  vpc_id = aws_vpc.scz-low_spoke_vpc_a.id

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
      Name = "scz-low_spoke_vpc_a/${data.aws_availability_zones.available.names[count.index]}/tgw-subnet-route-table"
    },
  )
}

resource "aws_route_table_association" "scz-low_spoke_vpc_a_tgw_subnet_route_table_association" {
  count          = length(data.aws_availability_zones.available.names)
  route_table_id = aws_route_table.scz-low_spoke_vpc_a_tgw_subnet_route_table[count.index].id
  subnet_id      = aws_subnet.scz-low_spoke_vpc_a_endpoint_subnet[count.index].id
}

resource "aws_ec2_transit_gateway_vpc_attachment" "scz-low_spoke_vpc_a_tgw_attachment" {
  subnet_ids                                      = aws_subnet.scz-low_spoke_vpc_a_tgw_subnet[*].id
  transit_gateway_id                              = aws_ec2_transit_gateway.scz-low_ctrl_pln_tgw.id
  vpc_id                                          = aws_vpc.scz-low_spoke_vpc_a.id
  transit_gateway_default_route_table_association = false
  // Appliance mode might only be required for TGW Attachments towards Inspection/ANFW VPC
  #  appliance_mode_support                          = "enable"

  tags         = merge(var.tags,
    {
      Name = "scz-low_spoke-vpc-a-attachment"
    },
  )
}

resource "aws_ec2_transit_gateway_route_table_association" "scz-low_spoke_vpc_a_tgw_attachment_rt_association" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.scz-low_spoke_vpc_a_tgw_attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.scz-low_spoke_all_route_table.id
}


###############################################################
############# Spoke-B VPC TGW Attachment ############
###############################################################
resource "aws_subnet" "scz-low_spoke_vpc_b_tgw_subnet" {
  count                   = length(data.aws_availability_zones.available.names)
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.scz-low_spoke_vpc_b.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = cidrsubnet(local.scz-low_spoke_vpc_b_cidr, 8, 80 + count.index)

  tags         = merge(var.tags,
    {
      Name = "scz-low_spoke-vpc-b/${data.aws_availability_zones.available.names[count.index]}/tgw-subnet"
    },
  )
}

resource "aws_route_table" "scz-low_spoke_vpc_b_tgw_subnet_route_table" {
  count  = length(data.aws_availability_zones.available.names)
  vpc_id = aws_vpc.scz-low_spoke_vpc_b.id

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
      Name = "scz-low_spoke_vpc_b/${data.aws_availability_zones.available.names[count.index]}/tgw-subnet-route-table"
    },
  )
}

resource "aws_route_table_association" "scz-low_spoke_vpc_b_tgw_subnet_route_table_association" {
  count          = length(data.aws_availability_zones.available.names)
  route_table_id = aws_route_table.scz-low_spoke_vpc_b_tgw_subnet_route_table[count.index].id
  subnet_id      = aws_subnet.scz-low_spoke_vpc_b_endpoint_subnet[count.index].id
}

resource "aws_ec2_transit_gateway_vpc_attachment" "scz-low_spoke_vpc_b_tgw_attachment" {
  subnet_ids                                      = aws_subnet.scz-low_spoke_vpc_b_tgw_subnet[*].id
  transit_gateway_id                              = aws_ec2_transit_gateway.scz-low_ctrl_pln_tgw.id
  vpc_id                                          = aws_vpc.scz-low_spoke_vpc_b.id
  transit_gateway_default_route_table_association = false

  tags         = merge(var.tags,
    {
      Name = "scz-low_spoke-vpc-b-attachment"
    },
  )
}

resource "aws_ec2_transit_gateway_route_table_association" "scz-low_spoke_vpc_b_tgw_attachment_rt_association" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.scz-low_spoke_vpc_b_tgw_attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.scz-low_spoke_all_route_table.id
}


###############################################################
############# Spoke-All VPC TGW Attachment ############
###############################################################
resource "aws_ec2_transit_gateway_route_table" "scz-low_spoke_all_route_table" {
  transit_gateway_id = aws_ec2_transit_gateway.scz-low_ctrl_pln_tgw.id

  tags         = merge(var.tags,
    {
      Name = "spoke-route-table"
    },
  )
}

// Need to review if this should be created on both spoke tgw attachment route tables
#resource "aws_ec2_transit_gateway_route" "scz-low_spoke_route_table_default_route" {
#  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.scz-low_spoke_vpc_a_tgw_attachment.id
#  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.scz-low_spoke_all_route_table.id
#  destination_cidr_block         = "0.0.0.0/0"
#}

###############################################################
############# Inspection VPC TGW Attachment ############
###############################################################
# Control Plane VPC TGW Attachment CIDR Subnet, Route Table & Association
#resource "aws_subnet" "scz-low_inspection_vpc_tgw_subnet" {
#  count                   = length(data.aws_availability_zones.available.names)
#  map_public_ip_on_launch = false
#  vpc_id                  = aws_vpc.scz-low_inspection_vpc.id
#  availability_zone       = data.aws_availability_zones.available.names[count.index]
#  cidr_block              = cidrsubnet(local.scz-low_inspection_vpc_cidr, 4, 0 + count.index)
#
#  tags         = merge(var.tags,
#    {
#      Name = "scz-low_inspection_vpc/${data.aws_availability_zones.available.names[count.index]}/tgw-subnet"
#    },
#  )
#}
#
#resource "aws_route_table" "scz-low_inspection_vpc_tgw_subnet_route_table" {
#  count  = length(data.aws_availability_zones.available.names)
#  vpc_id = aws_vpc.scz-low_inspection_vpc.id

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
#      Name = "scz-low_inspection_vpc/${data.aws_availability_zones.available.names[count.index]}/tgw-subnet-route-table"
#    },
#  )
#}

#resource "aws_route_table_association" "scz-low_inspection_vpc_tgw_subnet_route_table_association" {
#  count          = length(data.aws_availability_zones.available.names)
#  route_table_id = aws_route_table.scz-low_inspection_vpc_tgw_subnet_route_table[count.index].id
#  subnet_id      = aws_subnet.scz-low_inspection_vpc_tgw_subnet[count.index].id
#}
#
#resource "aws_ec2_transit_gateway_vpc_attachment" "scz-low_inspection_vpc_tgw_attachment" {
#  subnet_ids                                      = aws_subnet.scz-low_inspection_vpc_tgw_subnet[*].id
#  transit_gateway_id                              = aws_ec2_transit_gateway.scz-low_ctrl_pln_tgw.id
#  vpc_id                                          = aws_vpc.scz-low_inspection_vpc.id
#  transit_gateway_default_route_table_association = false
#
#  tags         = merge(var.tags,
#    {
#      Name = "scz-low_inspection-vpc-attachment"
#    },
#  )
#}




// I dont think I need this because this would be the pre-inspection and post-inspection route tables
#resource "aws_ec2_transit_gateway_route_table" "scz-low_inspection_tgw_route_table" {
#  transit_gateway_id = aws_ec2_transit_gateway.scz-low_ctrl_pln_tgw.id
#
#  tags         = merge(var.tags,
#    {
#      Name = "scz-low_inspection_tgw-route-table"
#    },
#  )
#}

// Not sure if this is needed
#resource "aws_ec2_transit_gateway_route_table_association" "scz-low_inspection_vpc_tgw_attachment_rtr_association" {
#  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.scz-low_inspection_vpc_tgw_attachment.id
# transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.scz-low_inspection_tgw_route_table.id
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

