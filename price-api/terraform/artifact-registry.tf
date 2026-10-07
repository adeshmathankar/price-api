resource "google_artifact_registry_repository" "price_api" {
  location      = var.region
  repository_id = var.artifact_repository
  description   = "Container images for price-api"
  format        = "DOCKER"

  depends_on = [
    google_project_service.required
  ]
}