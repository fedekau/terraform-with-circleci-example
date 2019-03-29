output "web-alb-dns-name" {
  value = "${module.staging-infrastructure.web-alb-dns-name}"
}

output "web-instance-ips" {
  value = "${module.staging-infrastructure.web-instance-ips}"
}
