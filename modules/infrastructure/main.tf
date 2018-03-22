module "network" {
  source = "modules/network"

  environment = "${var.environment}"
}

module "instances" {
  source = "modules/instances"

  environment = "${var.environment}"

  vpc-id             = "${module.network.vpc-id}"
  public-a-subnet-id = "${module.network.public-a-subnet-id}"
  public-b-subnet-id = "${module.network.public-b-subnet-id}"
}

module "databases" {
  source = "modules/databases"

  environment = "${var.environment}"

  vpc-id              = "${module.network.vpc-id}"
  private-a-subnet-id = "${module.network.private-a-subnet-id}"
  private-b-subnet-id = "${module.network.private-b-subnet-id}"
}
