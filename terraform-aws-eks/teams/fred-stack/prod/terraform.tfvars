### Backend
dynamodb_table-name = "fred-statefile-lock"
s3-bucket-name      = "843825445314-us-east-1-terraform-state"
#Network Details
region   = "us-east-1"
vpc_name = "fred-stack"
vpc_cidr = "10.0.0.0/24"

#Cluster Details
cluster_name    = "stack-cluster"
cluster_version = "1.26"
csi-role-name   = "role"
#Ncpu ode Group Details
node_group_name = "stack-manage-ng"
max_size        = "16"
min_size        = "3"
desired_size    = "3"

#3 GPU node Group Name
# gpu_group_name   = "gpu-manage-ng"
# gpu_max_size     = "16"
# gpu_min_size     = "1"
# gpu_desired_size = "1"

#Bastion Host Daetails
bastion-host_name = "team-name"
key_name          = "apache-keypair"