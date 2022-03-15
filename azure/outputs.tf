output "remote_user" {
  value = trimspace(basename(pathexpand("~")))
}
