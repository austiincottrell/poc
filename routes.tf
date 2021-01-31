resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.secure_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "Public Subnets"
  }
}

resource "aws_route_table_association" "subnet0" {
  subnet_id      = aws_subnet.subnet[0].id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "subnet1" {
  subnet_id      = aws_subnet.subnet[1].id
  route_table_id = aws_route_table.public_route.id
}

#====================================================

resource "aws_eip" "nat_gw_eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_gw_eip.id
  subnet_id     = aws_subnet.subnet[0].id
}

#====================================================


resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.secure_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "Private Subnets"
  }
}

resource "aws_route_table_association" "subnet2" {
  subnet_id      = aws_subnet.subnet[2].id
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "subnet3" {
  subnet_id      = aws_subnet.subnet[3].id
  route_table_id = aws_route_table.private_route.id
}