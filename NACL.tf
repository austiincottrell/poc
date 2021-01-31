resource "aws_network_acl" "secure_private_subnet" {
  vpc_id = aws_vpc.secure_vpc.id
  subnet_ids = [aws_subnet.subnet[2].id, aws_subnet.subnet[3].id]
  
  dynamic "ingress" {
    for_each = var.nacl_ingress_ports
    content {
      from_port  = ingress.value["port"]
      to_port    = ingress.value["port"]
      protocol   = "tcp"
      action     = "allow"
      cidr_block = var.my_cidr_block
      rule_no    = ingress.value["rule"]
    }
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = var.myip
    from_port  = 22
    to_port    = 22
  }

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = local.nacl_name
  }
}
