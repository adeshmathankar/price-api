resource "google_compute_network" "vpc" {
  name                    = var.network_name
  auto_create_subnetworks = false

  depends_on = [
    google_project_service.required
  ]
}

resource "google_compute_subnetwork" "gke" {
  name          = var.subnet_name
  region        = var.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = "10.10.0.0/20"

  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = "10.20.0.0/16"
  }

  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = "10.30.0.0/20"
  }
}