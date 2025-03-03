
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
  default = {
    vpc = {
      vpc_name   = "beijing_vpc"
      cidr_block = "192.168.0.0/16"
    }
    vswitches = [{
      zone_id    = "cn-beijing-g"
      cidr_block = "192.168.1.0/24"
      }, {
      zone_id    = "cn-beijing-i"
      cidr_block = "192.168.2.0/24"
    }]
    tr_vpc_attachment = {
      transit_router_attachment_name        = "TR-Attachment-Beijing"
      transit_router_attachment_description = "Transit Router Attachment for Beijing Region"
    }
  }
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
  default = {
    vpc = {
      vpc_name   = "shanghai_vpc"
      cidr_block = "10.0.0.0/16"
    }
    vswitches = [{
      zone_id    = "cn-shanghai-m"
      cidr_block = "10.0.1.0/24"
      }, {
      zone_id    = "cn-shanghai-n"
      cidr_block = "10.0.2.0/24"
    }]
    tr_vpc_attachment = {
      transit_router_attachment_name        = "TR-Attachment-Shanghai"
      transit_router_attachment_description = "Transit Router Attachment for Shanghai Region"
    }
  }
}

