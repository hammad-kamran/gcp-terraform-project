provider "google" {
  credentials = file("devsecops-444309-a9a87b9171cf.json")
  project = "devsecops-444309"
  region  = "us-central1"
}

resource "google_compute_instance" "my_manual_vm" {
  name         = "my-manual-vm"
  zone         = "us-central1-a"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "https://www.googleapis.com/compute/v1/projects/debian-cloud/global/images/debian-12-bookworm-v20241210"
      size  = 10
      type  = "pd-balanced"
    }
  }

  network_interface {
    network    = "default"  # Use default network, or specify your own
    subnetwork = "default"  # Use default subnetwork, or specify a custom one
    
    access_config {
      // This gives the VM an external IP
    }
  }

  tags = ["http-server", "https-server"]

  labels = {
    goog-terraform-provisioned = "true"
  }
}
