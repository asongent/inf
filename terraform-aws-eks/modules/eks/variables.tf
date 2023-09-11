variable "cluster_name" {
  description = "EKS Cluster name"
}
variable "node_group_name" {
  description = "EKS node group name"
}
variable "worker_node_role_arn" {
  description = "EKS node group role arn"
}
variable "private_subnet_id" {
  type        = list(string)
  description = "List of subnets to deploy node groups - this should be a list of private subnets"
}
# possible values [AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64]
variable "ami_type" {
  description = "AMI Type for node group selecect from - [AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64]"
}
#Valid Values [ON_DEMAND, SPOT]
variable "capacity_type" {
  description = "Instance capacity type either ON_DEMAND, SPOT, OR RESERVED "
}
variable "instance_types" {
  description = "Select type of instance, t2.micro, m5.large etc."
}
# should be a map of string any formats below:
#{
#  KEY = "John"
#  VALUE  = "doe"
#}
# {KEY = "John", VALUE = "doe"}
variable "labels" {
  type        = map(string)
  description = "List of subnets that EKS contol plane will deploy ENI to"
}
variable "desired_size" {
  type = number
  description = "desired node count for cluster node group"
}
variable "max_size" {
  type = number
  description = "Max size for nodes in the node group"
}
variable "min_size" {
  type = number
  description = "Min size for nodes in the node group"
}
variable "cluster_create_wait" {
  description = "wait for cluster creation"
}
# variable "worker_node_sg_id" {
#   description = "worker node security group id"
# }
# variable "tags" {
#   type        = map(string)
#   description = "Tags to apply to eks nodegroups"
# }
# variable "ssh_key_name" {
#   description = "name of ssh key to use"
# }
# variable "worker_node_sg" {
#   description = "remote_access source_security_group_ids"
# }
