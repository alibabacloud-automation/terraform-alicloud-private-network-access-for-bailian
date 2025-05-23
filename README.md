Terraform module to establish a secure access channel through PrivateLink for bailian on Alibaba Cloud

terraform-alicloud-private-network-access-for-bailian
======================================

English | [简体中文](https://github.com/alibabacloud-automation/terraform-alicloud-private-network-access-for-bailian/blob/main/README-CN.md)

The official release of the DeepSeek R1 large model has garnered widespread attention from the global technology community. As a high-performance generative AI model that is both open-source and free to use, DeepSeek R1 has demonstrated core performance metrics comparable to GPT-o1 in several benchmark tests. Numerous developers and enterprise users have already begun technical validation and scenario adaptation work.  
Alibaba Cloud's Bailian platform now offers public network API access to the DeepSeek model. However, while public network access provides convenience, its potential data security risks pose a significant challenge for enterprise-level applications, specifically in the following dimensions:
- Encryption Vulnerabilities in Transmission Links: Public network communication is susceptible to man-in-the-middle attacks, potentially compromising data transmission security.
- Risk of Request Log Retention: Traffic logs on third-party network nodes may lead to sensitive data leakage.
- Industry Compliance Requirements: Highly regulated sectors like finance, healthcare, and automotive have explicit compliance constraints regarding data transmission paths.  

To meet the core data security and compliance demands of enterprise users, we recommend establishing a secure access channel through PrivateLink. This solution offers the following advantages:
- Establishes an end-to-end private network environment.
- Enables stable service invocation with millisecond-level latency.
- Meets industry regulatory compliance requirements.
- Provides auditable data flow path tracing.


Architecture Diagram:

![image](https://raw.githubusercontent.com/alibabacloud-automation/terraform-alicloud-private-network-access-for-bailian/main/scripts/diagram.png)


## Usage


```hcl
provider "alicloud" {
  alias  = "local_region"
  region = "cn-beijing"
}

provider "alicloud" {
  alias  = "remote_region"
  region = "cn-shanghai"
}

module "complete" {
  source = "alibabacloud-automation/private-network-access-for-bailian/alicloud"

  providers = {
    alicloud.local_region  = alicloud.local_region
    alicloud.remote_region = alicloud.remote_region
  }

  local_vpc_config = {
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

  remote_vpc_config = {
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
```

## Examples

* [Complete Example](https://github.com/alibabacloud-automation/terraform-alicloud-private-network-access-for-bailian/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_alicloud.local_region"></a> [alicloud.local\_region](#provider\_alicloud.local\_region) | n/a |
| <a name="provider_alicloud.remote_region"></a> [alicloud.remote\_region](#provider\_alicloud.remote\_region) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_local_vpc"></a> [local\_vpc](#module\_local\_vpc) | ./modules/vpc | n/a |
| <a name="module_remote_vpc"></a> [remote\_vpc](#module\_remote\_vpc) | ./modules/vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_cen_instance.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/cen_instance) | resource |
| [alicloud_cen_transit_router.local](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/cen_transit_router) | resource |
| [alicloud_cen_transit_router.remote](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/cen_transit_router) | resource |
| [alicloud_cen_transit_router_peer_attachment.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/cen_transit_router_peer_attachment) | resource |
| [alicloud_cen_transit_router_route_table_association.beijing_peer_attachment](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_association.shanghai_peer_attachment](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_propagation.beijing_peer_propagation](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/cen_transit_router_route_table_propagation) | resource |
| [alicloud_cen_transit_router_route_table_propagation.shanghai_peer_propagation](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/cen_transit_router_route_table_propagation) | resource |
| [alicloud_privatelink_vpc_endpoint.dashscope_endpoint](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/privatelink_vpc_endpoint) | resource |
| [alicloud_privatelink_vpc_endpoint_zone.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/privatelink_vpc_endpoint_zone) | resource |
| [alicloud_pvtz_zone.dashscope_pvtz_zone](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/pvtz_zone) | resource |
| [alicloud_pvtz_zone_attachment.remote_vpc_attachment](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/pvtz_zone_attachment) | resource |
| [alicloud_pvtz_zone_record.dashscope_cname_record](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/pvtz_zone_record) | resource |
| [alicloud_security_group.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.http_ingress_rule](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.https_ingress_rule](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_cen_transit_router_route_tables.local](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/cen_transit_router_route_tables) | data source |
| [alicloud_cen_transit_router_route_tables.remote](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/cen_transit_router_route_tables) | data source |
| [alicloud_regions.remote](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cen_instance_config"></a> [cen\_instance\_config](#input\_cen\_instance\_config) | The parameters of cen instance. | <pre>object({<br>    cen_instance_name = optional(string, "main_cen_instance")<br>    description       = optional(string, null)<br>    protection_level  = optional(string, "REDUCED")<br>  })</pre> | `{}` | no |
| <a name="input_local_tr_config"></a> [local\_tr\_config](#input\_local\_tr\_config) | The parameters of local transit router. | <pre>object({<br>    transit_router_name        = optional(string, "local-tr")<br>    transit_router_description = optional(string, null)<br>  })</pre> | `{}` | no |
| <a name="input_local_vpc_config"></a> [local\_vpc\_config](#input\_local\_vpc\_config) | The parameters of local vpc resources. The attributes 'vpc', 'vswitches' are required. | <pre>object({<br>    vpc = object({<br>      cidr_block = string<br>      vpc_name   = optional(string, null)<br>    })<br>    vswitches = list(object({<br>      zone_id      = string<br>      cidr_block   = string<br>      vswitch_name = optional(string, null)<br>    }))<br>    tr_vpc_attachment = optional(object({<br>      transit_router_attachment_name        = optional(string, null)<br>      transit_router_attachment_description = optional(string, null)<br>      auto_publish_route_enabled            = optional(bool, true)<br>    }), {})<br>  })</pre> | n/a | yes |
| <a name="input_privatelink_vpc_endpoint"></a> [privatelink\_vpc\_endpoint](#input\_privatelink\_vpc\_endpoint) | The parameters of privatelink vpc endpoint. | <pre>object({<br>    service_name      = optional(string, "com.aliyuncs.dashscope")<br>    vpc_endpoint_name = optional(string, "pvltest_dashscope_endpoint")<br>  })</pre> | `{}` | no |
| <a name="input_pvtz_zone_name"></a> [pvtz\_zone\_name](#input\_pvtz\_zone\_name) | The name of pvtz zone. | `string` | `"vpc-cn-beijing.dashscope.aliyuncs.com"` | no |
| <a name="input_pvtz_zone_record"></a> [pvtz\_zone\_record](#input\_pvtz\_zone\_record) | The parameters of pvtz zone record. | <pre>object({<br>    rr     = optional(string, "@")<br>    type   = optional(string, "CNAME")<br>    ttl    = optional(number, 15)<br>    status = optional(string, "ENABLE")<br>  })</pre> | `{}` | no |
| <a name="input_remote_tr_config"></a> [remote\_tr\_config](#input\_remote\_tr\_config) | The parameters of remote transit router. | <pre>object({<br>    transit_router_name        = optional(string, "remote-tr")<br>    transit_router_description = optional(string, null)<br>  })</pre> | `{}` | no |
| <a name="input_remote_vpc_config"></a> [remote\_vpc\_config](#input\_remote\_vpc\_config) | The parameters of remote vpc resources. The attributes 'vpc', 'vswitches' are required. | <pre>object({<br>    vpc = object({<br>      cidr_block = string<br>      vpc_name   = optional(string, null)<br>    })<br>    vswitches = list(object({<br>      zone_id      = string<br>      cidr_block   = string<br>      vswitch_name = optional(string, null)<br>    }))<br>    tr_vpc_attachment = optional(object({<br>      transit_router_attachment_name = optional(string, null)<br>      auto_publish_route_enabled     = optional(bool, true)<br>    }), {})<br>  })</pre> | n/a | yes |
| <a name="input_security_group_config"></a> [security\_group\_config](#input\_security\_group\_config) | The parameters of security group. | <pre>object({<br>    security_group_name = optional(string, "main-security-group")<br>    description         = optional(string, "for Privatelink")<br>  })</pre> | `{}` | no |
| <a name="input_tr_peer_attachment"></a> [tr\_peer\_attachment](#input\_tr\_peer\_attachment) | The parameters of transit router peer attachment. | <pre>object({<br>    transit_router_attachment_name = optional(string, "TR-Peer-Attachment")<br>    auto_publish_route_enabled     = optional(bool, true)<br>    bandwidth_type                 = optional(string, "DataTransfer")<br>    bandwidth                      = optional(number, 10)<br><br>  })</pre> | `{}` | no |

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

## Submit Issues

If you have any problems when using this module, please opening
a [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend opening an issue on this repo.

## Authors

Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

## License

MIT Licensed. See LICENSE for full details.

## Reference

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)
