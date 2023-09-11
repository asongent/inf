variable "region" {
    default = "us-east-1"
}
variable "vpc_name" {
    default = "tap_eks_cluster_VPC"
}
variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"
}
variable "cluster_name" {
    default = "tap_test_cluster_non-prod"
}
variable "node_group_name" {
    default = "vCPU_node_group"
}

