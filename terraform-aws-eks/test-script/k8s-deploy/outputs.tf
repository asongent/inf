output "cluster_name" {
  description = "The Name of EKS Cluster you are deploying to"
  value = data.aws_eks_cluster.eks_deploy.id
}
output "region" {
  description = "AWS region"
  value       = data.terraform_remote_state.eks_deploy.outputs.region
}
