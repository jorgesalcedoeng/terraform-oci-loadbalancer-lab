resource "oci_core_instance" "vm" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = var.compartment_ocid
  display_name        = "${var.project_name}-app-vm"

  shape = "VM.Standard.E4.Flex"

  shape_config {
    ocpus         = 1
    memory_in_gbs = 4
  }

  create_vnic_details {
    subnet_id        = var.private_subnet_id
    assign_public_ip = false
    nsg_ids          = [var.private_nsg_id]
  }

  source_details {
    source_type = "image"
    source_id   = "ocid1.image.oc1.iad.aaaaaaaabhr2qauihgil7n62c6kdpzbbtl2hbrhdsnl5oszn7azsz4xbiraa"
  }

  metadata = {
    ssh_authorized_keys = file("${path.root}/oci-lab.pub")
    user_data           = base64encode(file("${path.module}/user_data.yaml"))
  }
}

resource "oci_core_instance" "vm2" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = var.compartment_ocid
  display_name        = "${var.project_name}-app-vm2"

  shape = "VM.Standard.E4.Flex"

  shape_config {
    ocpus         = 1
    memory_in_gbs = 4
  }

  create_vnic_details {
    subnet_id        = var.private_subnet_id
    assign_public_ip = false
    nsg_ids          = [var.private_nsg_id]
  }

  source_details {
    source_type = "image"
    source_id   = "ocid1.image.oc1.iad.aaaaaaaabhr2qauihgil7n62c6kdpzbbtl2hbrhdsnl5oszn7azsz4xbiraa"
  }

  metadata = {
    ssh_authorized_keys = file("${path.root}/oci-lab.pub")
    user_data           = base64encode(file("${path.module}/user_data.yaml"))
  }
}
