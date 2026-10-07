output "cluster_name" {
  description = "GKE cluster name"
  value       = google_container_cluster.price_api.name
}

output "cluster_location" {
  description = "GKE cluster location"
  value       = google_container_cluster.price_api.location
}

output "cluster_endpoint" {
  description = "GKE cluster endpoint"
  value       = google_container_cluster.price_api.endpoint
  sensitive   = true
}

output "network_name" {
  description = "VPC network"
  value       = google_compute_network.vpc.name
}

output "subnet_name" {
  description = "GKE subnet"
  value       = google_compute_subnetwork.gke.name
}

output "artifact_registry_repository" {
  description = "Artifact Registry repository"
  value       = google_artifact_registry_repository.price_api.name
}

output "artifact_registry_url" {
  description = "Artifact Registry Docker URL"
  value       = "${var.region}-docker.pkg.dev/${var.project_id}/${var.artifact_repository}"
}

output "node_service_account" {
  description = "GKE node service account"
  value       = google_service_account.gke_nodes.email
}