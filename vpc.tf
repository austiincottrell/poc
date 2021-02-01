resource "aws_vpc" "secure_vpc" {
  enable_dns_support = true
  cidr_block = var.my_cidr_block

  tags = {
    Name = local.vpc_name
  }
}

resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.secure_vpc.id
  map_public_ip_on_launch = element(var.public_subnet, count.index)
  count                   = 4

  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = cidrsubnet(var.my_cidr_block, 8, count.index)

  tags = {
    name = element(var.subnet_name, count.index)
    Name = element(var.subnet_name, count.index)
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.secure_vpc.id
}
