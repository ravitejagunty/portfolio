output "eks_cluster_name" {
  value = aws_eks_cluster.mfe-eks-cluster.name
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.mfe-eks-cluster.endpoint
}

output "eks_cluster_certificate_authority_data" {
  value = aws_eks_cluster.mfe-eks-cluster.certificate_authority[0].data
}
