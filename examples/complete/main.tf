provider "alicloud" {
  alias  = "local_region"
  region = "cn-beijing"
}

provider "alicloud" {
  alias  = "remote_region"
  region = "cn-shanghai"
}

module "complete" {
  source = "../.."
  providers = {
    alicloud.local_region  = alicloud.local_region
    alicloud.remote_region = alicloud.remote_region
  }

  local_vpc_config = var.local_vpc_config

  remote_vpc_config = var.remote_vpc_config

}