module "network" {
  source = "./modules/network"

  compartment_ocid = var.compartment_ocid
  project_name     = var.project_name

  vcn_cidr            = var.vcn_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr

  tags = var.tags
}

module "compute" {
  source           = "./modules/compute"
  compartment_ocid = var.compartment_ocid
  project_name     = var.project_name

  public_subnet_id  = module.network.public_subnet_id
  private_subnet_id = module.network.private_subnet_id
  public_nsg_id     = module.network.public_nsg_id
  private_nsg_id    = module.network.private_nsg_id
  tags              = var.tags

}
