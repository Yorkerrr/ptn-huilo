data "google_compute_image" "my_image" {
  family  = "ubuntu-2004-lts"
  project = "ubuntu-os-cloud"
}

data "template_file" "script" {
  template = file("${path.module}/script.sh")
}

resource "google_compute_instance_template" "ddos" {
  name         = "ddos-tpl"
  machine_type = var.vm_type
  tags = ["ddos"]
  project = var.project_id
  disk {
    source_image = data.google_compute_image.my_image.self_link
  }
  network_interface {
    network = var.network
    access_config {
    }
  }
  
  scheduling {
    preemptible = var.preemptible
    automatic_restart = var.preemptible? false : true
  }
  metadata_startup_script = data.template_file.script.rendered
}

resource "google_compute_region_instance_group_manager" "ddos" {
  name = "ddos-igm"
  project = var.project_id
  base_instance_name = "ddos"
  region = var.region

  version {
    instance_template  = google_compute_instance_template.ddos.id
  }
  target_size  = var.vm_count
}

resource "google_compute_firewall" "rules" {
  name        = "allow-ddos-out"
  network     = var.network
  project     = var.project_id
  description = "Creates firewall rule targeting tagged instances"
  direction = "EGRESS"
  target_tags = ["ddos"]
  allow {
    protocol  = "tcp"
    ports     = ["80", "443"]
  }
}