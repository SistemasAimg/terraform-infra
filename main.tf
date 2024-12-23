module "im-workspace" {
  source = "terraform-google-modules/bootstrap/google//modules/im_cloudbuild_workspace"
  version = "~> 7.0"

  project_id                  = "storage-entorno-de-desarrollo"
  deployment_id               = "infra-manager-deployment"
  im_deployment_repo_uri      = "https://github.com/SistemasAimg/terraform-infra.git"
  im_deployment_ref           = "main"  # Cambia si usas otra rama predeterminada

  github_app_installation_id  = "58476315"  # Consulta el ID en GitHub
  github_personal_access_token = "github-token" # Nombre del secreto
}



provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.66.0" # Cambia esto a la última versión estable
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 4.66.0" # Cambia esto a la última versión estable
    }
  }
}

resource "google_cloudbuild_trigger" "general_build_trigger" {
  name     = var.cloud_build_name
  filename = "cloudbuild.yaml"
  project  = var.project_id
  github {
    owner = var.github_owner
    name  = var.github_repository
    push {
      branch = "master" # Cambia 'main' por el nombre de tu rama, si es diferente
    }
  }
  substitutions = {
    _SERVICE_ACCOUNT = var.service_account_email
  }
}


resource "google_artifact_registry_repository" "artifact_repo" {
  repository_id = var.artifact_repo_id
  project       = var.project_id
  location      = var.region
  description   = "Repositorio para imágenes Docker"
  format        = "DOCKER"
}

resource "google_cloud_run_v2_job" "cloud_run_job" {
  provider = google
  name     = var.cloud_run_job_name
  project  = var.project_id
  location = var.region

  template {
    template {
      service_account = var.service_account_email
      containers {
        image = "us-central1-docker.pkg.dev/${var.project_id}/${var.artifact_repo_id}/${var.artifact_image}"
        resources {
          limits = {
            memory = var.memory_limit
          }
        }
      }
    }
  }
}

