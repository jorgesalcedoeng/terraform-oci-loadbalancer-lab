output "loadbalancer_ip" {
  value = oci_load_balancer_load_balancer.lb.ip_address_details[0].ip_address
}