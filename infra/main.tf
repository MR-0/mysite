variable "PROJECT" {
  type     = string
  nullable = false
}
variable "REGION" {
  type     = string
  nullable = false
}
variable "DOCKER_ARTIFACT_PATH" {
  type     = string
  nullable = false
}

variable "TERRAFORM_STATE_BUCKET" {
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

data "terraform_remote_state" "state" {
  backend = "gcs"
  config = {
    bucket = var.TERRAFORM_STATE_BUCKET
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.PROJECT
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_artifact_registry_repository" "images" {
  location      = var.REGION
  repository_id = var.DOCKER_ARTIFACT_PATH
  format        = "DOCKER"
}
