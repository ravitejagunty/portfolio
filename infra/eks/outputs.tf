output "eks_cluster_name" {
  value = module.eks.eks_cluster_name
}

output "node_group_name" {
  value = module.node-group.node_group_name
}

output "services" {
  value = module.deployment.service_name
}