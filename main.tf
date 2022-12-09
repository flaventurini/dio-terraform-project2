terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
  }
}

  backend "gcs" {
    bucket = "flaventuriniterraform"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = "flaventurini-devops-iac"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_instance" "vm_instance" {
  name = "terraform-instance"
  machine_type = "e2-small"
  tags = [ "prod" ]

  labels = {
    centro_custo = "rh"
  }

  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20221206"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {

    }
  }
}