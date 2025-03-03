# vpc
output "vpc_id" {
  value       = alicloud_vpc.this.id
  description = "The id of vpc."
}

output "vpc_cidr_block" {
  value       = alicloud_vpc.this.cidr_block
  description = "The cidr block of vpc."
}


output "vpc_route_table_id" {
  value       = alicloud_vpc.this.route_table_id
  description = "The route table id of vpc."
}

output "vswitch_ids" {
  value       = alicloud_vswitch.this[*].id
  description = "The ids of vswitches."
}

output "vswitch_zone_ids" {
  value       = alicloud_vswitch.this[*].zone_id
  description = "The zone ids of vswitches."
}

output "tr_vpc_attachment_id" {
  value       = alicloud_cen_transit_router_vpc_attachment.this.transit_router_attachment_id
  description = "The id of attachment between TR and VPC."
}


