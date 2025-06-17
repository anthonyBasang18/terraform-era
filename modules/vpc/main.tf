######################################
# Locals (with validation + routing logic)
######################################

locals {
  nat_gateway_azs = (
    var.create_nat_gateway && var.nat_gateway_strategy == "multi"
    ? keys(var.public_subnets)
    : var.create_nat_gateway
      ? [keys(var.public_subnets)[0]]
      : []
  )

  private_route_table_keys = (
    var.create_nat_gateway && var.nat_gateway_strategy == "multi"
    ? keys(var.private_subnets)
    : var.create_nat_gateway && var.nat_gateway_strategy == "single"
      ? ["shared"]
      : []
  )

  private_rt_names = {
    for k in local.private_route_table_keys :
    k => var.nat_gateway_strategy == "multi" ? "${var.name}-private-rt-${k}" : "${var.name}-private-rt"
  }

  invalid_nat_strategy = !var.create_nat_gateway && var.nat_gateway_strategy != ""
}

######################################
# VPC
######################################
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name}-vpc"
  }
}

######################################
# Internet Gateway
######################################
resource "aws_internet_gateway" "this" {
  count  = var.create_internet_gateway ? 1 : 0
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.name}-igw"
  }
}

######################################
# Subnets
######################################
resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = {
    Name = each.value.name
  }
}

resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = each.value.name
  }
}

######################################
# NAT Gateway + EIP (Conditional)
######################################
resource "aws_eip" "nat" {
  for_each = toset(local.nat_gateway_azs)
  domain   = "vpc"
}

resource "aws_nat_gateway" "this" {
  for_each = {
    for k, v in var.public_subnets :
    k => v
    if contains(local.nat_gateway_azs, k)
  }

  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = aws_subnet.public[each.key].id

  tags = {
    Name = "${var.name}-nat-${each.key}"
  }

  depends_on = [aws_internet_gateway.this]
}

######################################
# Public Route Table
######################################
resource "aws_route_table" "public" {
  count  = var.create_internet_gateway ? 1 : 0
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.name}-public-rt"
  }
}

resource "aws_route" "public_internet" {
  count                  = var.create_internet_gateway ? 1 : 0
  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this[0].id
}

resource "aws_route_table_association" "public_subnets" {
  for_each = var.create_internet_gateway ? aws_subnet.public : {}

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public[0].id
}

######################################
# Private Route Table
######################################
resource "aws_route_table" "private" {
  for_each = { for key in local.private_route_table_keys : key => key }

  vpc_id = aws_vpc.this.id

  tags = {
    Name = local.private_rt_names[each.key]
  }
}

resource "aws_route" "private_nat" {
  for_each = var.create_nat_gateway ? aws_route_table.private : {} 

  route_table_id         = each.value.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = (
    var.nat_gateway_strategy == "multi"
    ? aws_nat_gateway.this[each.key].id
    : aws_nat_gateway.this[keys(aws_nat_gateway.this)[0]].id
  )
}

resource "aws_route_table_association" "private_subnets" {
  for_each = var.create_nat_gateway ? aws_subnet.private : {}

  subnet_id = each.value.id

  route_table_id = (
    var.nat_gateway_strategy == "multi"
    ? aws_route_table.private[each.key].id
    : aws_route_table.private["shared"].id
  )
}

######################################
# VPC Flow Logs (Optional)
######################################
resource "aws_cloudwatch_log_group" "vpc_flow_logs" {
  count             = var.enable_flow_logs ? 1 : 0
  name              = "/aws/vpc/flowlogs/${var.name}"
  retention_in_days = 30
}

resource "aws_flow_log" "this" {
  count = var.enable_flow_logs ? 1 : 0

  log_destination_type = "cloud-watch-logs"
  log_destination      = aws_cloudwatch_log_group.vpc_flow_logs[0].arn
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.this.id

  iam_role_arn = var.flow_log_role_arn != "" ? var.flow_log_role_arn : aws_iam_role.vpc_flow_log[0].arn
}

# resource "null_resource" "validate_nat_config" {
#   count = local.invalid_nat_strategy ? 1 : 0

#   provisioner "local-exec" {
#     command = "echo '❌ Invalid config: nat_gateway_strategy requires create_nat_gateway = true' && exit 1"
#   }

#   lifecycle {
#     prevent_destroy = true
#   }
# }
