variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_region" {
  default = "us-east-1"
}
variable "common_name" {
  default = "go-test"
}
variable "instance_type_spot" {
  default = "t2.micro"
  type    = string
}
variable "spot_bid_price" {
  default = "0.0085"
}
variable "cluster_name" {
  default = "go-test-cluster"
  type    = string
}
variable "min_spot" {
  default     = "1"
  description = "The minimum EC2 spot instances to be available"
}
variable "max_spot" {
  default     = "3"
  description = "The maximum EC2 spot instances that can be launched at peak time"
}
