output "elb_dns" {
  description = "Elastic Load Balancer DNS"
  value       = "${module.web.elb_dns}"
}

