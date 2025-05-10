desired_size = 2
min_size = 2
max_size = 6
instance_types = ["t2.micro"]
vpc_cidr = "10.1.0.0/16"
public_subnet_cidrs = ["10.1.0.0/19", "10.1.32.0/19", "10.1.64.0/19"]
private_subnet_cidrs = ["10.1.96.0/19", "10.1.128.0/19", "10.1.160.0/19"]
common_tags = {"Environment" = "QA", "Owner" = "Sanoj Technologies"}
project_name = "Demo_EKS_QA"