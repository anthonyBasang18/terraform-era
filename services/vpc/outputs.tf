output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_ids" {
  value = [for s in aws_subnet.public : s.id]
}

output "private_subnet_ids" {
  value = [for s in aws_subnet.private : s.id]
}

output "nat_gateway_ids" {
  value = var.create_nat_gateway ? [for ngw in aws_nat_gateway.this : ngw.id] : []
}

output "public_route_table_id" {
  value = var.create_internet_gateway ? aws_route_table.public[0].id : null
}

output "private_route_table_ids" {
  value = var.create_nat_gateway ? [for rt in aws_route_table.private : rt.id] : []
}

output "nat_gateway_strategy" {
  value = var.create_nat_gateway ? var.nat_gateway_strategy : "none"
}
