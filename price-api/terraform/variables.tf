variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "asia-south1"
}

variable "zone" {
  description = "GCP zone"
  type        = string
  default     = "asia-south1-a"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "cluster_name" {
  description = "GKE cluster name"
  type        = string
  default     = "price-api-gke"
}

variable "network_name" {
  description = "VPC network name"
  type        = string
  default     = "price-api-vpc"
}

variable "subnet_name" {
  description = "GKE subnet name"
  type        = string
  default     = "price-api-subnet"
}

variable "artifact_repository" {
  description = "Artifact Registry repository name"
  type        = string
  default     = "price-api"
}

variable "node_machine_type" {
  description = "GKE node machine type"
  type        = string
  default     = "e2-standard-2"
}

variable "min_nodes" {
  description = "Minimum number of nodes"
  type        = number
  default     = 1
}

variable "max_nodes" {
  description = "Maximum number of nodes"
  type        = number
  default     = 3
}