locals {
  subnet_cidr_priv = cidrsubnets(var.vpc_cidr, 2, 2, 2, 2, )
}
locals {
  subnet_cidr_pub = cidrsubnets(local.subnet_cidr_priv[2], 2, 2, 2, 2, )
}
data "aws_availability_zones" "available" {
  state = "available"
}
module "vpc" {
  source         = "../../../modules/vpc"
  cidr_block_vpc = var.vpc_cidr
  vpc_name       = var.vpc_name
}

module "subnet" {
  count                  = 2
  source                 = "../../../modules/subnet"
  vpc_id                 = module.vpc.vpc_id
  cidr_block_subnet_pub  = local.subnet_cidr_pub[count.index]                       #var.cidr_pub[count.index]
  cidr_block_subnet_priv = local.subnet_cidr_priv[count.index]                      #var.cidr_priv[count.index]
  availability_zone      = data.aws_availability_zones.available.names[count.index] #var.azs[count.index]
  vpc_name               = var.vpc_name
  public_route_table     = module.vpc.public_route_table_id
  cluster_name           = var.cluster_name

}

module "eks_cluster" {
  source             = "../../../modules/eks_cluster"
  vpc_id             = module.vpc.vpc_id
  node_sg            = module.eks_node_group.node_sg_id
  cluster_name       = var.cluster_name
  cluster_version    = var.cluster_version
  /* private_subnet_ids = concat(module.subnet[*].private_subnet, module.subnet[*].public_subnet) #original */
  private_subnet_ids = concat(module.subnet[*].private_subnet, module.subnet[*].public_subnet) #testing
  cluster_sg_ids     = [module.eks_cluster.cluster_sg_id, module.eks_node_group.node_sg_id]
  csi-role-name      = var.csi-role-name
}


module "eks_node_group" {
  source              = "../../../modules/eks_node_group"
  vpc_id              = module.vpc.vpc_id
  cluster_sg          = module.eks_cluster.cluster_sg_id
  cluster_name        = var.cluster_name
  node_group_name     = var.node_group_name
  private_subnet_id   = module.subnet[*].private_subnet
  desired_size        = var.desired_size
  max_size            = var.max_size
  min_size            = var.min_size
  ami_type            = "AL2_x86_64"
  capacity_type       = "SPOT"
  instance_types      = ["m5.xlarge", "m5n.xlarge", "m5d.xlarge", "m5dn.xlarge", "m5a.xlarge", "m4.xlarge"]
  labels              = { node = "vcpu", type = "spot" }
  cluster_create_wait = module.eks_cluster.endpoint

}




module "bastion-host" {
  source           = "../../../modules/bastion-host"
  vpc_id           = module.vpc.vpc_id
  subnet_id        = module.subnet[1].public_subnet
  public_subnet_id = module.subnet[1].public_subnet
  instance_type    = var.instance_type
  key_name         = var.key_name
  ami_type         = var.ami
  ami              = "ami-0261755bbcb8c4a84"
}

/* module "ebs-csi-driver" {
  source       = "../../../modules/ebs-csi-driver"
  cluster_name = var.cluster_name
} */