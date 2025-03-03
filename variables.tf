# CEN instance
variable "cen_instance_config" {
  description = "The parameters of cen instance."
  type = object({
    cen_instance_name = optional(string, "main_cen_instance")
    description       = optional(string, null)
    protection_level  = optional(string, "REDUCED")
  })
  default = {}
}

# TR
variable "local_tr_config" {
  description = "The parameters of local transit router."
  type = object({
    transit_router_name        = optional(string, "local-tr")
    transit_router_description = optional(string, null)
  })
  default = {}
}

variable "remote_tr_config" {
  description = "The parameters of remote transit router."
  type = object({
    transit_router_name        = optional(string, "remote-tr")
    transit_router_description = optional(string, null)
  })
  default = {}
}

# VPC
variable "local_vpc_config" {
  description = "The parameters of local vpc resources. The attributes 'vpc', 'vswitches' are required."
  type = object({
    vpc = object({
      cidr_block = string
      vpc_name   = optional(string, null)
    })
    vswitches = list(object({
      zone_id      = string
      cidr_block   = string
      vswitch_name = optional(string, null)
    }))
    tr_vpc_attachment = optional(object({
      transit_router_attachment_name        = optional(string, null)
      transit_router_attachment_description = optional(string, null)
      auto_publish_route_enabled            = optional(bool, true)
    }), {})
  })
}

variable "remote_vpc_config" {
  description = "The parameters of remote vpc resources. The attributes 'vpc', 'vswitches' are required."
  type = object({
    vpc = object({
      cidr_block = string
      vpc_name   = optional(string, null)
    })
    vswitches = list(object({
      zone_id      = string
      cidr_block   = string
      vswitch_name = optional(string, null)
    }))
    tr_vpc_attachment = optional(object({
      transit_router_attachment_name = optional(string, null)
      auto_publish_route_enabled     = optional(bool, true)
    }), {})
  })
}

variable "tr_peer_attachment" {
  description = "The parameters of transit router peer attachment."
  type = object({
    transit_router_attachment_name = optional(string, "TR-Peer-Attachment")
    auto_publish_route_enabled     = optional(bool, true)
    bandwidth_type                 = optional(string, "DataTransfer")
    bandwidth                      = optional(number, 10)

  })
  default = {}
}

variable "security_group_config" {
  description = "The parameters of security group."
  type = object({
    security_group_name = optional(string, "main-security-group")
    description         = optional(string, "for Privatelink")
  })
  default = {}
}

variable "privatelink_vpc_endpoint" {
  description = "The parameters of privatelink vpc endpoint."
  type = object({
    service_name      = optional(string, "com.aliyuncs.dashscope")
    vpc_endpoint_name = optional(string, "pvltest_dashscope_endpoint")
  })
  default = {}
}

variable "pvtz_zone_name" {
  description = "The name of pvtz zone."
  type        = string
  default     = "vpc-cn-beijing.dashscope.aliyuncs.com"
}

variable "pvtz_zone_record" {
  description = "The parameters of pvtz zone record."
  type = object({
    rr     = optional(string, "@")
    type   = optional(string, "CNAME")
    ttl    = optional(number, 15)
    status = optional(string, "ENABLE")
  })
  default = {}

}