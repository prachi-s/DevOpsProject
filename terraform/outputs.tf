output "load_balancer_ip" {
  description = "Public IP address - access your service at http://THIS_IP"
  value       = google_compute_global_forwarding_rule.http.ip_address
}

output "cloud_run_service_name" {
  value = google_cloud_run_v2_service.myapp.name
}