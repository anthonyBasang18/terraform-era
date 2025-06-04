module "vpc" {
  source = "../../../services/vpc"

  name                = var.name
  vpc_cidr            = var.vpc_cidr

  create_internet_gateway = var.create_internet_gateway
  create_nat_gateway      = var.create_nat_gateway
  nat_gateway_strategy    = var.nat_gateway_strategy
  enable_flow_logs        = var.enable_flow_logs
  flow_log_role_arn       = var.flow_log_role_arn

  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}
