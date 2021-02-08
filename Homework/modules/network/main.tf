terraform {
  required_version = ">=0.12"
}

/*==== The VPC ======*/
resource "aws_vpc" "main" {
  cidr_block  = var.vpc_cidr
  tags = {
    Name      = "main"
  }
}

/*==== Subnets ======*/
/* Internet gateway for the public subnet */
resource "aws_internet_gateway" "ig" {
  vpc_id        = aws_vpc.main.id
  tags = {
    Name        = "internet_gateway"
  }
//}
///* Elastic IP for NAT */
//resource "aws_eip" "nat_eip" {
//  vpc        = true
//  depends_on = [aws_internet_gateway.ig]
//}
///* NAT */
//resource "aws_nat_gateway" "nat" {
//  allocation_id = aws_eip.nat_eip.id
//  subnet_id     = aws_subnet.public_subnet.id
//  depends_on    = [aws_internet_gateway.ig]
//  tags = {
//    Name        = "nat"
//  }
}
/* Public subnet */
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zones
  map_public_ip_on_launch = true
  tags = {
    Name        = "public-subnet"
  }
}
/* Private subnet */
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_cidr
  availability_zone       = var.availability_zones
  map_public_ip_on_launch = false
  tags = {
    Name        = "private-subnet"
  }
}
/* Routing table for private subnet */
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name        = "private-route-table"
  }
}
/* Routing table for public subnet */
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name        = "public-route-table"
  }
}
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig.id
}
//resource "aws_route" "private_nat_gateway" {
//  route_table_id         = aws_route_table.private.id
//  destination_cidr_block = "0.0.0.0/0"
//  nat_gateway_id         = aws_nat_gateway.nat.id
//}
/* Route table associations */
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private.id
}
