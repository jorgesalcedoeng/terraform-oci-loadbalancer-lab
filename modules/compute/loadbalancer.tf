resource "oci_load_balancer_load_balancer" "lb" {
  compartment_id             = var.compartment_ocid
  display_name               = "${var.project_name}-lb"
  shape                      = "flexible"
  network_security_group_ids = [var.public_nsg_id]

  shape_details {
    minimum_bandwidth_in_mbps = 10
    maximum_bandwidth_in_mbps = 100
  }

  lifecycle {
    create_before_destroy = true
  }

  subnet_ids = [var.public_subnet_id]

  is_private = false

}

resource "oci_load_balancer_backend_set" "backend_set" {
  load_balancer_id = oci_load_balancer_load_balancer.lb.id
  name             = "${var.project_name}-backend-set"
  policy           = "ROUND_ROBIN"

  health_checker {
    protocol = "HTTP"
    port     = 80
    url_path = "/"
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    oci_load_balancer_load_balancer.lb
  ]

}

resource "oci_load_balancer_listener" "http_listener" {
  load_balancer_id         = oci_load_balancer_load_balancer.lb.id
  name                     = "listener-http"
  default_backend_set_name = oci_load_balancer_backend_set.backend_set.name
  port                     = 80
  protocol                 = "HTTP"

  depends_on = [
    oci_load_balancer_backend_set.backend_set
  ]

}

resource "oci_load_balancer_backend" "backend" {

  load_balancer_id = oci_load_balancer_load_balancer.lb.id
  backendset_name  = oci_load_balancer_backend_set.backend_set.name
  ip_address       = oci_core_instance.vm.private_ip
  port             = 80

  depends_on = [
    oci_load_balancer_listener.http_listener
  ]

}

resource "oci_load_balancer_backend" "backend2" {

  load_balancer_id = oci_load_balancer_load_balancer.lb.id
  backendset_name  = oci_load_balancer_backend_set.backend_set.name
  ip_address       = oci_core_instance.vm2.private_ip
  port             = 80

  depends_on = [
    oci_load_balancer_listener.http_listener
  ]
}
