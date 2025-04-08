output "deployment_name" {
  value = values(kubernetes_deployment.mfe-deployment)[*].metadata[0].name
}

output "service_name" {
  value = values(kubernetes_service.mfe-service)[*].metadata[0].name
}