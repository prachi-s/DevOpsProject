# Load Balancer -> serverless NEG -> Cloud Run
resource "google_compute_region_network_endpoint_group" "neg" {
  name                  = "my-neg"
  region                = var.region
  network_endpoint_type = "SERVERLESS"

  cloud_run {
    service = google_cloud_run_v2_service.myapp.name
  }

  depends_on = [
    google_cloud_run_v2_service.myapp
  ]
}

# Backend service 
resource "google_compute_backend_service" "backend" {
  name                  = "my-backend"
  protocol              = "HTTPS"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  timeout_sec = 30

  backend {
    group = google_compute_region_network_endpoint_group.neg.id
  }
}

# URL routing
resource "google_compute_url_map" "url_map" {
  name            = "my-url-map"
  default_service = google_compute_backend_service.backend.id
}

# HTTP proxy
resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "my-http-proxy"
  url_map = google_compute_url_map.url_map.id
}

# Forwarding rule
resource "google_compute_global_forwarding_rule" "http" {
  name       = "my-http-fr"
  load_balancing_scheme = "EXTERNAL_MANAGED" 
  target    = google_compute_target_http_proxy.http_proxy.id
  port_range = "80"
  ip_protocol = "TCP"
}
