variable "env_id" {}

variable "location" {}

variable "pcf_resource_group_name" {
  type = "string"
}

#variable "pcf_harbor_public_ip" {}
#Can't register DNS here.  Must be manual in domain.com
#variable "dns_suffix" {}

variable "harbor_subnet_id" {}
variable "lb_subnet_id" {}
variable "harbor_lb_priv_ip" {}