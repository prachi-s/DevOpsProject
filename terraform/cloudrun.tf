# Cloud Run service
resource "google_cloud_run_v2_service" "myapp" {
  name     = "myapp-service"
  location = var.region

  template {
    containers {
        image = var.image

        ports {
          container_port = 8080
        }
      }

    vpc_access {
      connector = google_vpc_access_connector.connector.id
      egress = "ALL_TRAFFIC"
    }

  }

  ingress = "INGRESS_TRAFFIC_INTERNAL_LOAD_BALANCER"
}

# Give loadbalancer SA permission to invoke CloudRun service
resource "google_cloud_run_v2_service_iam_binding" "lb_invoker" {
  name  = google_cloud_run_v2_service.myapp.name
  location = var.region
  role     = "roles/run.invoker"
  members   = [
    "serviceAccount:service-${var.project_number}@serverless-robot-prod.iam.gserviceaccount.com"
  ]
}
