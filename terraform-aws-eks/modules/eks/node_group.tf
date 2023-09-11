resource "aws_eks_node_group" "example" {
  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = var.worker_node_role_arn
  subnet_ids      = var.private_subnet_id
  ami_type        = var.ami_type # possible values [AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64]
  capacity_type   = var.capacity_type #Valid Values [ON_DEMAND, SPOT]
  instance_types  = var.instance_types
  labels          = var.labels #key-value map
  # tags            = var.tags #key-value map
  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  # remote_access {
  #   source_security_group_ids  = [aws_security_group.worker_node_sg.id]
  #   ec2_ssh_key                = var.ssh_key_name
  # }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
#     aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
#     aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
#     aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    var.cluster_create_wait
  ]
}
