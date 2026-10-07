1. Project Structure

price-api/
├── app.py
├── requirements.txt
├── Dockerfile
├── .dockerignore
├── k8s/
│   ├── namespace.yaml
│   ├── secret.yaml
│   ├── deployment.yaml
│   ├── service.yaml
│   └── servicemonitor.yaml
└── terraform/
    ├── versions.tf
    ├── variables.tf
    ├── terraform.tfvars
    ├── apis.tf
    ├── network.tf
    ├── artifact-registry.tf
    ├── iam.tf
    ├── gke.tf
    └── outputs.tf



**Deploy the API to Kind**
1.kubectl apply -f k8s\namespace.yaml
2.kubectl apply -f k8s\secret.yaml
3.kubectl apply -f k8s\deployment.yaml
4.kubectl apply -f k8s\service.yaml
5.kubectl get all -n pricing
6.kubectl get pods -n pricing


**Start the API Server Through Port Forwarding**
1.Keep this CMD window open:
kubectl port-forward -n pricing svc/price-api 8080:80
2.Open a second CMD window and test:
curl http://localhost:8080/healthz
curl http://localhost:8080/price
curl http://localhost:8080/metrics


**Terraform Quick Start**
cd C:\Users\<User-name>\price-api\terraform
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
gcloud container clusters get-credentials price-api-gke --zone asia-south1-a
kubectl config current-context
kubectl get nodes
