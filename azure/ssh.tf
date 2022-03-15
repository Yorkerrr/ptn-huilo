locals {
  ssh_key_path = pathexpand("~/.ssh/glory_to_ukraine_azure")
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_sensitive_file" "ssh" {
    content  = tls_private_key.ssh.private_key_pem
    filename = local.ssh_key_path
}

resource "null_resource" "add_key" {
  triggers = {
    key = tls_private_key.ssh.private_key_pem
  }
  provisioner "local-exec" {
    command = "ssh-add $KEY_PATH || key was not added!"
    environment = {
      KEY_PATH = local.ssh_key_path
     }
  }
}

