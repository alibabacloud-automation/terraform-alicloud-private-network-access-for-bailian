
# Complete

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_complete"></a> [complete](#module\_complete) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_local_vpc_config"></a> [local\_vpc\_config](#input\_local\_vpc\_config) | The parameters of local vpc resources. The attributes 'vpc', 'vswitches' are required. | <pre>object({<br>    vpc = object({<br>      cidr_block = string<br>      vpc_name   = optional(string, null)<br>    })<br>    vswitches = list(object({<br>      zone_id      = string<br>      cidr_block   = string<br>      vswitch_name = optional(string, null)<br>    }))<br>    tr_vpc_attachment = optional(object({<br>      transit_router_attachment_name        = optional(string, null)<br>      transit_router_attachment_description = optional(string, null)<br>      auto_publish_route_enabled            = optional(bool, true)<br>    }), {})<br>  })</pre> | <pre>{<br>  "tr_vpc_attachment": {<br>    "transit_router_attachment_description": "Transit Router Attachment for Beijing Region",<br>    "transit_router_attachment_name": "TR-Attachment-Beijing"<br>  },<br>  "vpc": {<br>    "cidr_block": "192.168.0.0/16",<br>    "vpc_name": "beijing_vpc"<br>  },<br>  "vswitches": [<br>    {<br>      "cidr_block": "192.168.1.0/24",<br>      "zone_id": "cn-beijing-g"<br>    },<br>    {<br>      "cidr_block": "192.168.2.0/24",<br>      "zone_id": "cn-beijing-i"<br>    }<br>  ]<br>}</pre> | no |
| <a name="input_remote_vpc_config"></a> [remote\_vpc\_config](#input\_remote\_vpc\_config) | The parameters of remote vpc resources. The attributes 'vpc', 'vswitches' are required. | <pre>object({<br>    vpc = object({<br>      cidr_block = string<br>      vpc_name   = optional(string, null)<br>    })<br>    vswitches = list(object({<br>      zone_id      = string<br>      cidr_block   = string<br>      vswitch_name = optional(string, null)<br>    }))<br>    tr_vpc_attachment = optional(object({<br>      transit_router_attachment_name = optional(string, null)<br>      auto_publish_route_enabled     = optional(bool, true)<br>    }), {})<br>  })</pre> | <pre>{<br>  "tr_vpc_attachment": {<br>    "transit_router_attachment_description": "Transit Router Attachment for Shanghai Region",<br>    "transit_router_attachment_name": "TR-Attachment-Shanghai"<br>  },<br>  "vpc": {<br>    "cidr_block": "10.0.0.0/16",<br>    "vpc_name": "shanghai_vpc"<br>  },<br>  "vswitches": [<br>    {<br>      "cidr_block": "10.0.1.0/24",<br>      "zone_id": "cn-shanghai-m"<br>    },<br>    {<br>      "cidr_block": "10.0.2.0/24",<br>      "zone_id": "cn-shanghai-n"<br>    }<br>  ]<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cen_instance_id"></a> [cen\_instance\_id](#output\_cen\_instance\_id) | The ID of the CEN instance |
| <a name="output_local_route_table_id"></a> [local\_route\_table\_id](#output\_local\_route\_table\_id) | The ID of the local TR route table |
| <a name="output_local_transit_router_id"></a> [local\_transit\_router\_id](#output\_local\_transit\_router\_id) | The ID of the local transit router |
| <a name="output_local_vpc_cidr_block"></a> [local\_vpc\_cidr\_block](#output\_local\_vpc\_cidr\_block) | The CIDR block of the local VPC |
| <a name="output_local_vpc_id"></a> [local\_vpc\_id](#output\_local\_vpc\_id) | The ID of the local VPC |
| <a name="output_local_vswitch_ids"></a> [local\_vswitch\_ids](#output\_local\_vswitch\_ids) | The list of IDs of the local VSwitches |
| <a name="output_privatelink_endpoint_id"></a> [privatelink\_endpoint\_id](#output\_privatelink\_endpoint\_id) | The ID of the PrivateLink VPC endpoint |
| <a name="output_pvtz_zone_id"></a> [pvtz\_zone\_id](#output\_pvtz\_zone\_id) | The ID of the PrivateZone |
| <a name="output_pvtz_zone_record_id"></a> [pvtz\_zone\_record\_id](#output\_pvtz\_zone\_record\_id) | The ID of the PrivateZone record |
| <a name="output_remote_route_table_id"></a> [remote\_route\_table\_id](#output\_remote\_route\_table\_id) | The ID of the remote TR route table |
| <a name="output_remote_transit_router_id"></a> [remote\_transit\_router\_id](#output\_remote\_transit\_router\_id) | The ID of the remote transit router |
| <a name="output_remote_vpc_cidr_block"></a> [remote\_vpc\_cidr\_block](#output\_remote\_vpc\_cidr\_block) | The CIDR block of the remote VPC |
| <a name="output_remote_vpc_id"></a> [remote\_vpc\_id](#output\_remote\_vpc\_id) | The ID of the remote VPC |
| <a name="output_remote_vswitch_ids"></a> [remote\_vswitch\_ids](#output\_remote\_vswitch\_ids) | The list of IDs of the remote VSwitches |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the security group |
<!-- END_TF_DOCS -->