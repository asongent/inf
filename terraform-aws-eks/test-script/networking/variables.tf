variable "region" {
    default = "us-east-1"
}
variable "vpc_name" {
    default = "tap_eks_cluster_VPC"
}
variable "vpc_cidr" {
    default = "10.0.0.0/16"
}
variable "cidr_pub" {
  type    = list(string)
  default = [
    "10.0.0.0/19",
    "10.0.32.0/19",
    "10.0.64.0/19",
  ]
}
variable "cidr_priv" {
  type    = list(string)
  default = [
    "10.0.96.0/19",
    "10.0.128.0/19",
    "10.0.160.0/19",
  ]
}
variable "azs" {
  type    = list(string)
  default = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
  ]
}

