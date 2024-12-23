variable "project_id" {
  description = "ID del proyecto de Google Cloud"
  type        = string
}

variable "region" {
  description = "Región de Google Cloud"
  type        = string
}

variable "github_repository" {
  description = "Nombre del repositorio en GitHub"
  type        = string
}

variable "artifact_repo_name" {
  description = "Nombre del repositorio en Artifact Registry"
  type        = string
}

variable "artifact_image" {
  description = "Nombre de la imagen en Artifact Registry"
  type        = string
}

variable "cloud_build_name" {
  description = "Nombre del Google Cloud Build"
  type        = string
}

variable "cloud_run_job_name" {
  description = "Nombre del Google Cloud Run Job"
  type        = string
}

variable "memory_limit" {
  description = "Límite de memoria para los Cloud Run Jobs (en GB)"
  type        = string
  default     = "1Gi" # Valor predeterminado para todos los proyectos
}

variable "service_account_email" {
  description = "Cuenta de servicio para los recursos"
  type        = string
  default     = "cloudrun@storage-entorno-de-desarrollo.iam.gserviceaccount.com"
}

variable "build_trigger_name" {
  description = "Nombre del BUILD"
  type        = string
}

variable "github_owner" {
  description = "Cuenta de github"
  type        = string
  default     = "SistemasAimg"
}

variable "artifact_repo_id" {
  description = "ID repositorio Google"
  type        = string
}
