output "vpc_name" {
  value = var.vpc_name
}
output "vpc_id" {
  value = module.vpc.vpc_id
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