terraform {
  required_version = ">= 0.13"

  required_providers {
    
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

# Use the configuration for the backent.tf file in the ../eks_deploy directory
data "terraform_remote_state" "eks_deploy" {
  backend = "s3"
  config = {
    bucket = "" # s3 remote state bucket name
    key    = "" # path to state file should be unique per terraform directory
    dynamodb_table = "Tap-statefile-lock"
    region = "" # region where s3 bucket was created
  }
}

# data "terraform_remote_state" "eks_deploy" {
#   backend = "local"

#   config = {
#     path = "../eks_deploy/terraform.tfstate"
#   }
# }

provider "aws" {
    region = data.terraform_remote_state.eks_deploy.outputs.region
}

data "aws_eks_cluster" "eks_deploy" {
  name = data.terraform_remote_state.eks_deploy.outputs.cluster_name
}

data "aws_eks_cluster_auth" "eks_deploy" {
  name = data.terraform_remote_state.eks_deploy.outputs.cluster_name
}

provider "kubectl" {
  host                   = data.aws_eks_cluster.eks_deploy.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_deploy.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks_deploy.token
  load_config_file       = false
}

data "kubectl_path_documents" "bootstrap" {
    pattern = "./autoscaler.yaml"
    vars = {
        cluster_name = data.aws_eks_cluster.eks_deploy.id
    }
}

data "kubectl_path_documents" "apps" {
    pattern = "./ngin*.yaml"
}


resource "kubectl_manifest" "bootstrap" {
    count     = length(data.kubectl_path_documents.bootstrap.documents)
    yaml_body = element(data.kubectl_path_documents.bootstrap.documents, count.index)
}

resource "kubectl_manifest" "apps" {
    count      = length(data.kubectl_path_documents.apps.documents)
    yaml_body  = element(data.kubectl_path_documents.apps.documents, count.index)

    depends_on = [kubectl_manifest.bootstrap]
}
