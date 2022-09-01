variable "project" {
  type     = string
  nullable = false
}
variable "region" {
  type     = string
  nullable = false
}

variable "api_image" {
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


resource "google_cloud_run_service" "api" {
  name     = "api"
  location = var.region
  template {
    spec {
      containers {
        image = var.api_image
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}
