#Network Variables
variable "region" {
  default = "us-east-1"
}
variable "vpc_name" {
  default = "stack_eks_cluster_VPC"
}
variable "vpc_cidr" {
  type = string
  /* default = "10.0.0.0/16" */
}

#Cluster Configuration
variable "cluster_name" {
  default = "stack_non-prod_cluster"
}
variable "cluster_version" {
  type        = string
  default     = ""
  description = "The desired eks cluster that the team needs. Team must make sure their desired EKS version exists"
}

variable "node_group_name" {
  default = "stack_node_group"
}

variable "ami" {
  type    = string
  default = "AL2_x86_64"
}

variable "instance_type" {
  default = "t2.medium"
}

variable "bastion_host_name" {
  default = "public_ip"

}

### Additional variables for node groups
variable "desired_size" {
  type        = number
  description = "desired node count for cluster node group"
}
variable "max_size" {
  type        = number
  description = "Max size for nodes in the node group"
}
variable "min_size" {
  type        = number
  description = "Min size for nodes in the node group"
}


## Bastion Host

variable "key_name" {
  default = ""
}


