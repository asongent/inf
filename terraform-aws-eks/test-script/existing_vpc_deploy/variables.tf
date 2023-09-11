variable "region" {
    default = "us-east-1"
}
variable "vpc_id" {
    default = "tap_eks_cluster_VPC"
}
variable "cluster_name" {
    default = "tap_test_cluster_non-prod"
}
variable "node_group_name" {
    default = "vCPU_node_group"
}

