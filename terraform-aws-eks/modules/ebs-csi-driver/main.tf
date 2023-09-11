resource "aws_eks_addon" "ebs-csi-driver" {
  cluster_name                = var.cluster_name
  addon_name                  = "aws-ebs-csi-driver"
  addon_version               = "v1.20.0-eksbuild.1" 
  resolve_conflicts_on_update = "PRESERVE"
}