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
  name         = "api"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-97-lts"
    }
  }

  metadata {
    google-logging-enabled = "true"  
    gce-container-declaration = "spec:\ncontainers:\n- name: instance-4\n image: 'gcr.io/cloud-marketplace/google/nginx1:latest'\n stdin: false\n tty: false\n restartPolicy: Always\n"
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
}
