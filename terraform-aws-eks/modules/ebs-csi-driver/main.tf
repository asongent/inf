/* data "tls_certificate" "eks" {
  url = var.cluster_name.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
  url             = var.cluster_name.identity[0].oidc[0].issuer
}

data "aws_iam_policy_document" "csi" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "eks_ebs_csi_driver" {
  assume_role_policy = data.aws_iam_policy_document.csi.json
  name               = "eks-ebs-csi-driver"
}

resource "aws_iam_role_policy_attachment" "amazon_ebs_csi_driver" {
  role       = aws_iam_role.eks_ebs_csi_driver.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
} */
/* 
resource "aws_eks_addon" "ebs-csi-driver" {
  cluster_name                = var.cluster_name
  addon_name                  = "aws-ebs-csi-driver"
  addon_version               = "v1.20.0-eksbuild.1" 
  service_account_role_arn    = aws_iam_role.eks_ebs_csi_driver.arn
  resolve_conflicts_on_update = "PRESERVE"
} */

# Optional: only if you use your own KMS key to encrypt EBS volumes
# TODO: replace arn:aws:kms:us-east-1:424432388155:key/7a8ea545-e379-4ac5-8903-3f5ae22ea847 with your KMS key id arn!
# resource "aws_iam_policy" "eks_ebs_csi_driver_kms" {
#   name = "KMS_Key_For_Encryption_On_EBS"

#   policy = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Action": [
#         "kms:CreateGrant",
#         "kms:ListGrants",
#         "kms:RevokeGrant"
#       ],
#       "Resource": ["arn:aws:kms:us-east-1:424432388155:key/7a8ea545-e379-4ac5-8903-3f5ae22ea847"],
#       "Condition": {
#         "Bool": {
#           "kms:GrantIsForAWSResource": "true"
#         }
#       }
#     },
#     {
#       "Effect": "Allow",
#       "Action": [
#         "kms:Encrypt",
#         "kms:Decrypt",
#         "kms:ReEncrypt*",
#         "kms:GenerateDataKey*",
#         "kms:DescribeKey"
#       ],
#       "Resource": ["arn:aws:kms:us-east-1:424432388155:key/7a8ea545-e379-4ac5-8903-3f5ae22ea847"]
#     }
#   ]
# }
# POLICY
# }

# resource "aws_iam_role_policy_attachment" "amazon_ebs_csi_driver_kms" {
#   role       = aws_iam_role.eks_ebs_csi_driver.name
#   policy_arn = aws_iam_policy.eks_ebs_csi_driver_kms.arn
# }








/* 
resource "aws_iam_role" "ebs-csi-driver-role" {
  name        = "AmazonEKS_EBS_CSI_DriverRol"
  description = "This will be used allow dynamic provisioning of ebs volume in the cluster"
  assume_role_policy = file("ebs-csi-policy.json")

 */
