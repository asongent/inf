data "aws_vpc" "vpc_id" {
  id = var.vpc_id
}

data "aws_subnet_ids" "subnet_ids" {
  vpc_id = var.vpc_id
}

module eks_cluster {
    source                    = "../../modules/eks_cluster"
    vpc_id                    = data.aws_vpc.vpc_id.id
    node_sg                   = module.eks_node_group.node_sg_id
    cluster_name              = var.cluster_name
    private_subnet_ids        = [data.aws_subnet_ids.subnet_ids.ids]
    cluster_enpoint_cidr      = ["0.0.0.0/0"]
    cluster_sg_ids            = [module.eks_cluster.cluster_sg_id, module.eks_node_group.node_sg_id]
}

module eks_node_group {
    source                    = "../../modules/eks_node_group"
    vpc_id                    = data.aws_vpc.vpc_id.id
    cluster_sg                = module.eks_cluster.cluster_sg_id
    cluster_name              = var.cluster_name
    node_group_name           = var.node_group_name
    private_subnet_id         = [data.aws_subnet_ids.subnet_ids.ids]
    desired_size              = 2
    max_size                  = 6
    min_size                  = 1
    ami_type                  = "AL2_x86_64"
    capacity_type             = "SPOT"
    instance_types            = ["m5.xlarge", "m5n.xlarge", "m5d.xlarge", "m5dn.xlarge", "m5a.xlarge", "m4.xlarge"]
    labels                    = {node = "vcpu", type = "spot"}
    cluster_create_wait       = module.eks_cluster.endpoint
    # ssh_key_name            = ""
    # tags                      = {}
}
