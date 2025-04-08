resource "aws_vpc" "mfe-vpc" {
  cidr_block = var.vpc_cidr_block

  tags = var.tags
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.mfe-vpc.id
  tags   = var.tags
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.mfe-vpc.id
  tags   = var.tags

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "public-subnet" {
  count = length(var.public_subnets)

  vpc_id                  = aws_vpc.mfe-vpc.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags                    = var.tags

  lifecycle {
    ignore_changes = [map_public_ip_on_launch]
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public-subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_subnet" "private-subnet" {
  count = length(var.private_subnets)

  vpc_id            = aws_vpc.mfe-vpc.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = var.tags
}
