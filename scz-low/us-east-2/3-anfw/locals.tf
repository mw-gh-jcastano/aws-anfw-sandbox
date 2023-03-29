#locals {
##  firewall_vpc_endpoint_descriptions = [for ss in tolist(aws_networkfirewall_firewall.outbound.firewall_status[0].sync_states) : "VPC Endpoint Interface ${ss.attachment[0].endpoint_id}"]
#  firewall_vpc_endpoint_descriptions = [for ss in tolist(module.network_firewall.firewall_status[0].sync_states) : "VPC Endpoint Interface ${ss.attachment[0].endpoint_id}"]
#}

// TECH-DEBT to remove this to remove duplicate region values called in root module.  This is currently used for mapping the inspection vpc transit-gateway endpoint subnet
//and dedicated route table, to map to the same availability zone's network firewall endpoint in the az's firewall  subnet"
locals {
##  name   = "test-nfw"
  region = "us-east-2"
##  region = module.network_firewall.region
  azs    = ["${local.region}a", "${local.region}b", "${local.region}c"]
#  azs    = ["${var.region}a", "${var.region}b", "${var.region}c"]
#  azs    = ["${module.network_firewall.region}a", "${module.network_firewall.region}b", "${module.network_firewall.region}c"]
##  azs    = data.aws_availability_zones.available
}