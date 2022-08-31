variable "PROJECT" {
  type     = string
  nullable = false
}
variable "DOCKER_ARTIFACT_PATH" {
  type     = string
  nullable = false
}
variable "DOCKER_ARTIFACT_REGION" {
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
    bucket = "terraform-state-lrrthzu2"
    prefix = "terraform/state"
  }
}

data "terraform_remote_state" "state" {
  backend = "gcs"
  config = {
    bucket = "terraform-state-lrrthzu2"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.PROJECT
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_artifact_registry_repository" "images" {
  location      = var.DOCKER_ARTIFACT_REGION
  repository_id = var.DOCKER_ARTIFACT_PATH
  format        = "DOCKER"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance-2"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
}
