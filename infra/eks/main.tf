# Create the VPC
module "vpc" {
  source = "./vpc"

  # VPC configuration
  vpc_cidr_block  = var.vpc_cidr_block
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  tags            = var.tags
}

# Create the EKS cluster
module "eks" {
  source = "./eks"

  # EKS cluster configuration
  cluster_name       = var.cluster_name
  admin_iam_user_arn = var.admin_iam_user_arn
  subnet_ids         = module.vpc.public_subnet_ids
  tags               = var.tags
}

# Create the EKS node group
module "node-group" {
  source = "./node-group"

  # Node group configuration
  cluster_name    = module.eks.eks_cluster_name
  node_group_name = var.node_group_name
  instance_type   = var.instance_type
  desired_size    = var.desired_size
  max_size        = var.max_size
  min_size        = var.min_size
  subnet_ids      = module.vpc.public_subnet_ids
  tags            = var.tags
}

# Deploy the microfrontends
module "deployment" {
  source = "./deployment"

  # Deployment configuration
  microfrontends     = var.microfrontends
  dockerhub_username = var.dockerhub_username
  dockerhub_password = var.dockerhub_password
  dockerhub_email    = var.dockerhub_email

  providers = {
    kubernetes = kubernetes.eks
  }
}
