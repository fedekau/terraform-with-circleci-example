module "network" {
  source = "modules/network"

  environment = "${var.environment}"
}

module "instances" {
  source = "modules/instances"

  environment = "${var.environment}"

  public-a-subnet-id  = "${module.network.public-a-subnet-id}"
  public-b-subnet-id  = "${module.network.public-b-subnet-id}"
  private-a-subnet-id = "${module.network.private-a-subnet-id}"
  private-b-subnet-id = "${module.network.private-b-subnet-id}"

  allow-external-ssh-sg-id = "${module.network.allow-external-ssh-sg-id}"
}

module "databases" {
  source = "modules/databases"

  environment = "${var.environment}"

  public-a-subnet-id  = "${module.network.public-a-subnet-id}"
  public-b-subnet-id  = "${module.network.public-b-subnet-id}"
  private-a-subnet-id = "${module.network.private-a-subnet-id}"
  private-b-subnet-id = "${module.network.private-b-subnet-id}"

  allow-internal-ssh-sg-id = "${module.network.allow-internal-ssh-sg-id}"
}
