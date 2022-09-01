variable "project" {
  type     = string
  nullable = false
}
variable "region" {
  type     = string
  nullable = false
}
variable "docker_artifact_path" {
  type     = string
  nullable = false
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.34.0"
    }
  }

  backend "gcs" {
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = "us-central1-c"
}

resource "google_artifact_registry_repository" "images" {
  location      = var.region
  repository_id = var.docker_artifact_path
  format        = "DOCKER"
}
