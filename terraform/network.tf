# VPC creation
resource "google_compute_network" "vpc" {
  name                    = "my-vpc"
  auto_create_subnetworks = false
}

# Public subnets
resource "google_compute_subnetwork" "public_1" {
  name          = "public-1"
  region        = var.region
  ip_cidr_range = "10.0.1.0/24"
  network       = google_compute_network.vpc.id
}

resource "google_compute_subnetwork" "public_2" {
  name          = "public-2"
  region        = var.region
  ip_cidr_range = "10.0.2.0/24"
  network       = google_compute_network.vpc.id
}

# Private subnets
resource "google_compute_subnetwork" "private_1" {
  name                     = "private-1"
  region                   = var.region
  ip_cidr_range            = "10.0.11.0/24"
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "private_2" {
  name                     = "private-2"
  region                   = var.region
  ip_cidr_range            = "10.0.12.0/24"
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true
}

# VPC access connector
resource "google_vpc_access_connector" "connector" {
  name   = "my-connector"
  region = var.region
  network = google_compute_network.vpc.self_link
  ip_cidr_range = "10.8.0.0/28"
  max_instances = 3
  min_instances = 2
}
