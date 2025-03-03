output "cen_instance_id" {
  description = "The ID of the CEN instance"
  value       = alicloud_cen_instance.this.id
}

output "local_transit_router_id" {
  description = "The ID of the local transit router"
  value       = alicloud_cen_transit_router.local.transit_router_id
}


output "remote_transit_router_id" {
  description = "The ID of the remote transit router"
  value       = alicloud_cen_transit_router.remote.transit_router_id
}


output "local_route_table_id" {
  description = "The ID of the local TR route table"
  value       = local.local_tr_route_table_id
}

output "remote_route_table_id" {
  description = "The ID of the remote TR route table"
  value       = local.remote_tr_route_table_id
}

output "local_vpc_id" {
  description = "The ID of the local VPC"
  value       = module.local_vpc.vpc_id
}

output "local_vpc_cidr_block" {
  description = "The CIDR block of the local VPC"
  value       = module.local_vpc.vpc_cidr_block
}

output "local_vswitch_ids" {
  description = "The list of IDs of the local VSwitches"
  value       = module.local_vpc.vswitch_ids
}


output "remote_vpc_id" {
  description = "The ID of the remote VPC"
  value       = module.remote_vpc.vpc_id
}

output "remote_vpc_cidr_block" {
  description = "The CIDR block of the remote VPC"
  value       = module.remote_vpc.vpc_cidr_block
}

output "remote_vswitch_ids" {
  description = "The list of IDs of the remote VSwitches"
  value       = module.remote_vpc.vswitch_ids
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = alicloud_security_group.this.id
}


output "privatelink_endpoint_id" {
  description = "The ID of the PrivateLink VPC endpoint"
  value       = alicloud_privatelink_vpc_endpoint.dashscope_endpoint.id
}

output "pvtz_zone_id" {
  description = "The ID of the PrivateZone"
  value       = alicloud_pvtz_zone.dashscope_pvtz_zone.id
}

output "pvtz_zone_record_id" {
  description = "The ID of the PrivateZone record"
  value       = alicloud_pvtz_zone_record.dashscope_cname_record.id
}
