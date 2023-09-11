output "vpc_id" {
  value = data.aws_vpc.vpc_id.id
}
output "cluster_name" {
  value = var.cluster_name
}
output "cluster_endpoint" {
  value = module.eks_cluster.endpoint
}
output "region" {
  description = "AWS region"
  value       = var.region
}
