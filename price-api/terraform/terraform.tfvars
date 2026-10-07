project_id = "YOUR-GCP-PROJECT-ID"

region = "asia-south1"
zone   = "asia-south1-a"

environment = "dev"

cluster_name = "price-api-gke"

network_name = "price-api-vpc"

subnet_name = "price-api-subnet"

artifact_repository = "price-api"

node_machine_type = "e2-standard-2"

min_nodes = 1
max_nodes = 3