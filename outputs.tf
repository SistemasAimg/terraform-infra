
output "artifact_repo_name" {
  description = "Nombre del repositorio de Artifact Registry"
  value       = google_artifact_registry_repository.artifact_repo.name
}

output "service_account_email" {
  description = "El correo de la cuenta de servicio utilizada"
  value       = var.service_account_email
}
