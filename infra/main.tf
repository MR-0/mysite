variable "PROJECT" {
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
    bucket = google_storage_bucket.terraform_state.name
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.PROJECT
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_storage_bucket" "terraform_state" {
  name          = "terraform-state"
  location      = "US"
  storage_class = "ARCHIVE"
}

resource "google_artifact_registry_repository" "docker" {
  location      = "us-central1"
  repository_id = "docker"
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
    network = google_compute_network.vpc_network.self_link
    access_config {
    }
  }
}

resource "google_compute_network" "vpc_network" {
  name                    = "api-network"
  auto_create_subnetworks = "true"
}
