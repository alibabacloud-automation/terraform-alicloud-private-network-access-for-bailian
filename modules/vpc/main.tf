/*
 * vpc
 */
resource "alicloud_vpc" "this" {
  cidr_block  = var.vpc.cidr_block
  vpc_name    = var.vpc.vpc_name
  enable_ipv6 = var.vpc.enable_ipv6
  tags        = var.vpc.tags
}


resource "alicloud_vswitch" "this" {
  count = length(var.vswitches)

  vpc_id       = alicloud_vpc.this.id
  zone_id      = var.vswitches[count.index].zone_id
  cidr_block   = var.vswitches[count.index].cidr_block
  vswitch_name = var.vswitches[count.index].vswitch_name
}

resource "alicloud_cen_transit_router_vpc_attachment" "this" {
  cen_id                                = var.cen_instance_id
  transit_router_id                     = var.cen_transit_router_id
  vpc_id                                = alicloud_vpc.this.id
  transit_router_vpc_attachment_name    = var.tr_vpc_attachment.transit_router_attachment_name
  transit_router_attachment_description = var.tr_vpc_attachment.transit_router_attachment_description
  auto_publish_route_enabled            = var.tr_vpc_attachment.auto_publish_route_enabled
  dynamic "zone_mappings" {
    for_each = alicloud_vswitch.this
    content {
      zone_id    = zone_mappings.value.zone_id
      vswitch_id = zone_mappings.value.id
    }
  }
}

resource "alicloud_cen_transit_router_route_table_propagation" "this" {
  transit_router_route_table_id = var.cen_transit_router_route_table_id
  transit_router_attachment_id  = alicloud_cen_transit_router_vpc_attachment.this.transit_router_attachment_id
}

resource "alicloud_cen_transit_router_route_table_association" "this" {
  transit_router_route_table_id = var.cen_transit_router_route_table_id
  transit_router_attachment_id  = alicloud_cen_transit_router_vpc_attachment.this.transit_router_attachment_id
}

