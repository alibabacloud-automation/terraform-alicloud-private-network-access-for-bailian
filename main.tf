resource "alicloud_cen_instance" "this" {
  cen_instance_name = var.cen_instance_config.cen_instance_name
  description       = var.cen_instance_config.description
  protection_level  = var.cen_instance_config.protection_level
}

resource "alicloud_cen_transit_router" "local" {
  provider = alicloud.local_region

  cen_id                     = alicloud_cen_instance.this.id
  transit_router_name        = var.local_tr_config.transit_router_name
  transit_router_description = var.local_tr_config.transit_router_description
}

resource "alicloud_cen_transit_router" "remote" {
  provider = alicloud.remote_region

  cen_id                     = alicloud_cen_instance.this.id
  transit_router_name        = var.remote_tr_config.transit_router_name
  transit_router_description = var.remote_tr_config.transit_router_description
}


data "alicloud_cen_transit_router_route_tables" "local" {
  provider = alicloud.local_region

  transit_router_id               = alicloud_cen_transit_router.local.transit_router_id
  transit_router_route_table_type = "System"
}

data "alicloud_cen_transit_router_route_tables" "remote" {
  provider = alicloud.remote_region

  transit_router_id               = alicloud_cen_transit_router.remote.transit_router_id
  transit_router_route_table_type = "System"
}


locals {
  local_tr_route_table_id  = data.alicloud_cen_transit_router_route_tables.local.tables[0].transit_router_route_table_id
  remote_tr_route_table_id = data.alicloud_cen_transit_router_route_tables.remote.tables[0].transit_router_route_table_id
}

module "local_vpc" {
  providers = {
    alicloud = alicloud.local_region
  }

  source = "./modules/vpc"

  cen_instance_id                   = alicloud_cen_instance.this.id
  cen_transit_router_id             = alicloud_cen_transit_router.local.transit_router_id
  cen_transit_router_route_table_id = local.local_tr_route_table_id

  vpc               = var.local_vpc_config.vpc
  vswitches         = var.local_vpc_config.vswitches
  tr_vpc_attachment = var.local_vpc_config.tr_vpc_attachment
}

module "remote_vpc" {
  providers = {
    alicloud = alicloud.remote_region
  }

  source = "./modules/vpc"

  cen_instance_id                   = alicloud_cen_instance.this.id
  cen_transit_router_id             = alicloud_cen_transit_router.remote.transit_router_id
  cen_transit_router_route_table_id = local.remote_tr_route_table_id

  vpc               = var.remote_vpc_config.vpc
  vswitches         = var.remote_vpc_config.vswitches
  tr_vpc_attachment = var.remote_vpc_config.tr_vpc_attachment
}

data "alicloud_regions" "remote" {
  provider = alicloud.remote_region
  current  = true
}

# DataTransfer
resource "alicloud_cen_transit_router_peer_attachment" "this" {
  provider = alicloud.local_region

  cen_id                         = alicloud_cen_instance.this.id
  transit_router_id              = alicloud_cen_transit_router.local.transit_router_id
  peer_transit_router_region_id  = data.alicloud_regions.remote.regions[0].id
  peer_transit_router_id         = alicloud_cen_transit_router.remote.transit_router_id
  bandwidth_type                 = var.tr_peer_attachment.bandwidth_type
  bandwidth                      = var.tr_peer_attachment.bandwidth
  transit_router_attachment_name = var.tr_peer_attachment.transit_router_attachment_name
  auto_publish_route_enabled     = var.tr_peer_attachment.auto_publish_route_enabled
}

resource "alicloud_cen_transit_router_route_table_association" "shanghai_peer_attachment" {
  provider = alicloud.remote_region

  transit_router_route_table_id = local.remote_tr_route_table_id
  transit_router_attachment_id  = alicloud_cen_transit_router_peer_attachment.this.transit_router_attachment_id
}

resource "alicloud_cen_transit_router_route_table_association" "beijing_peer_attachment" {
  provider = alicloud.local_region

  transit_router_route_table_id = local.local_tr_route_table_id
  transit_router_attachment_id  = alicloud_cen_transit_router_peer_attachment.this.transit_router_attachment_id
}


resource "alicloud_cen_transit_router_route_table_propagation" "shanghai_peer_propagation" {
  provider = alicloud.remote_region

  transit_router_route_table_id = local.remote_tr_route_table_id
  transit_router_attachment_id  = alicloud_cen_transit_router_peer_attachment.this.transit_router_attachment_id
}

resource "alicloud_cen_transit_router_route_table_propagation" "beijing_peer_propagation" {
  provider = alicloud.local_region

  transit_router_route_table_id = local.local_tr_route_table_id
  transit_router_attachment_id  = alicloud_cen_transit_router_peer_attachment.this.transit_router_attachment_id
}



# security group
resource "alicloud_security_group" "this" {
  provider = alicloud.local_region

  security_group_name = var.security_group_config.security_group_name
  description         = var.security_group_config.description
  vpc_id              = module.local_vpc.vpc_id
}

resource "alicloud_security_group_rule" "http_ingress_rule" {
  provider = alicloud.local_region

  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = alicloud_security_group.this.id
  cidr_ip           = module.remote_vpc.vpc_cidr_block
}

resource "alicloud_security_group_rule" "https_ingress_rule" {
  provider = alicloud.local_region

  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "443/443"
  priority          = 1
  security_group_id = alicloud_security_group.this.id
  cidr_ip           = module.remote_vpc.vpc_cidr_block
}


# Privatelink
resource "alicloud_privatelink_vpc_endpoint" "dashscope_endpoint" {
  provider = alicloud.local_region

  service_name       = var.privatelink_vpc_endpoint.service_name
  vpc_endpoint_name  = var.privatelink_vpc_endpoint.vpc_endpoint_name
  security_group_ids = [alicloud_security_group.this.id]
  vpc_id             = module.local_vpc.vpc_id
}


resource "alicloud_privatelink_vpc_endpoint_zone" "this" {
  provider = alicloud.local_region
  for_each = { for i, id in module.local_vpc.vswitch_ids : i => id }

  endpoint_id = alicloud_privatelink_vpc_endpoint.dashscope_endpoint.id
  vswitch_id  = each.value
  zone_id     = module.local_vpc.vswitch_zone_ids[each.key]
}


resource "alicloud_pvtz_zone" "dashscope_pvtz_zone" {
  provider = alicloud.remote_region

  zone_name = var.pvtz_zone_name
}

resource "alicloud_pvtz_zone_record" "dashscope_cname_record" {
  provider = alicloud.remote_region

  zone_id = alicloud_pvtz_zone.dashscope_pvtz_zone.id
  value   = alicloud_privatelink_vpc_endpoint.dashscope_endpoint.endpoint_domain
  rr      = var.pvtz_zone_record.rr
  type    = var.pvtz_zone_record.type
  ttl     = var.pvtz_zone_record.ttl
  status  = var.pvtz_zone_record.status
}

resource "alicloud_pvtz_zone_attachment" "remote_vpc_attachment" {
  provider = alicloud.remote_region

  zone_id = alicloud_pvtz_zone.dashscope_pvtz_zone.id
  vpcs {
    vpc_id = module.remote_vpc.vpc_id
  }
}