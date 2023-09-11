module vpc {
    source = "../../modules/vpc"
    cidr_block_vpc         = var.vpc_cidr
    vpc_name               = var.vpc_name
}

module subnet {
    count                  = length(var.azs)
    source                 = "../../modules/subnet"
    vpc_id                 = module.vpc.vpc_id
    cidr_block_subnet_pub  = var.cidr_pub[count.index]
    cidr_block_subnet_priv = var.cidr_priv[count.index]
    availability_zone      = var.azs[count.index]
    vpc_name               = var.vpc_name
    public_route_table     = module.vpc.public_route_table_id
}
