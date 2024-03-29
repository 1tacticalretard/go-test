variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "common_name" {
  default = "ykushnir_go-test"
}

variable "public_subnet_cidr_list" {
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}

variable "private_subnet_cidr_list" {
  default = [
    "10.0.10.0/24",
    "10.0.20.0/24"
  ]
}
variable "security_group_ports" {
  type    = list(number)
  default = [80, 443, 22]
}
