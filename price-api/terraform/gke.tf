resource "google_container_cluster" "price_api" {
  name     = var.cluster_name
  location = var.zone

  network    = google_compute_network.vpc.id
  subnetwork = google_compute_subnetwork.gke.id

  deletion_protection = false

  remove_default_node_pool = true
  initial_node_count       = 1

  networking_mode = "VPC_NATIVE"

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  release_channel {
    channel = "REGULAR"
  }

  logging_config {
    enable_components = [
      "SYSTEM_COMPONENTS",
      "WORKLOADS"
    ]
  }

  monitoring_config {
    enable_components = [
      "SYSTEM_COMPONENTS"
    ]

    managed_prometheus {
      enabled = true
    }
  }

  network_policy {
    enabled  = true
    provider = "CALICO"
  }

  addons_config {
    http_load_balancing {
      disabled = false
    }

    horizontal_pod_autoscaling {
      disabled = false
    }
  }

  private_cluster_config {
    enable_private_nodes    = false
    enable_private_endpoint = false
  }

  depends_on = [
    google_project_service.required,
    google_compute_subnetwork.gke
  ]
}


resource "google_container_node_pool" "price_api" {
  name     = "${var.cluster_name}-nodes"
  location = var.zone
  cluster  = google_container_cluster.price_api.name

  initial_node_count = var.min_nodes

  autoscaling {
    min_node_count = var.min_nodes
    max_node_count = var.max_nodes
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    machine_type = var.node_machine_type

    service_account = google_service_account.gke_nodes.email

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    labels = {
      environment = var.environment
      application = "price-api"
    }

    tags = [
      "price-api-gke"
    ]

    metadata = {
      disable-legacy-endpoints = "true"
    }

    shielded_instance_config {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }

    workload_metadata_config {
      mode = "GKE_METADATA"
    }
  }

  depends_on = [
    google_project_iam_member.node_logging,
    google_project_iam_member.node_monitoring,
    google_project_iam_member.artifact_reader
  ]
}