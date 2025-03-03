output "cen_instance_id" {
  description = "The ID of the CEN instance"
  value       = module.complete.cen_instance_id
}

output "local_transit_router_id" {
  description = "The ID of the local transit router"
  value       = module.complete.local_transit_router_id
}


output "remote_transit_router_id" {
  description = "The ID of the remote transit router"
  value       = module.complete.remote_transit_router_id
}


output "local_route_table_id" {
  description = "The ID of the local TR route table"
  value       = module.complete.local_route_table_id
}

output "remote_route_table_id" {
  description = "The ID of the remote TR route table"
  value       = module.complete.remote_route_table_id
}

output "local_vpc_id" {
  description = "The ID of the local VPC"
  value       = module.complete.local_vpc_id
}

output "local_vpc_cidr_block" {
  description = "The CIDR block of the local VPC"
  value       = module.complete.local_vpc_cidr_block
}

output "local_vswitch_ids" {
  description = "The list of IDs of the local VSwitches"
  value       = module.complete.local_vswitch_ids
}


output "remote_vpc_id" {
  description = "The ID of the remote VPC"
  value       = module.complete.remote_vpc_id
}

output "remote_vpc_cidr_block" {
  description = "The CIDR block of the remote VPC"
  value       = module.complete.remote_vpc_cidr_block
}

output "remote_vswitch_ids" {
  description = "The list of IDs of the remote VSwitches"
  value       = module.complete.remote_vswitch_ids
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = module.complete.security_group_id
}


output "privatelink_endpoint_id" {
  description = "The ID of the PrivateLink VPC endpoint"
  value       = module.complete.privatelink_endpoint_id
}

output "pvtz_zone_id" {
  description = "The ID of the PrivateZone"
  value       = module.complete.pvtz_zone_id
}

output "pvtz_zone_record_id" {
  description = "The ID of the PrivateZone record"
  value       = module.complete.pvtz_zone_record_id
}
