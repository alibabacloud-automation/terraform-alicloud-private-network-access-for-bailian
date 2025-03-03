terraform {
  required_version = ">= 1.3"
  required_providers {
    alicloud = {
      source                = "hashicorp/alicloud"
      configuration_aliases = [alicloud.local_region, alicloud.remote_region]
    }
  }
}