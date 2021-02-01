resource "aws_security_group" "pub_vm" {
    vpc_id = aws_vpc.secure_vpc.id

    ingress {
    description = "SSH from my ip"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.myip]
    }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = local.sg_bastion_host
    }
}

resource "aws_security_group" "private_web_server" {
    vpc_id = aws_vpc.secure_vpc.id
    
    dynamic "ingress" {
    for_each = var.private_ingress_ports
    content {
        from_port   = ingress.value
        to_port     = ingress.value
        protocol    = "tcp"
        cidr_blocks = [var.my_cidr_block]
        }
    }

    dynamic "ingress" {
    for_each = var.public_ingress_ports
    content {
        from_port   = ingress.value
        to_port     = ingress.value
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        }
    }

    ingress {
    description = "http traffic from ALB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.ALB_security_group.id]
    }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = local.sg_private_host
    }
}

resource "aws_security_group" "ALB_security_group" {
    vpc_id = aws_vpc.secure_vpc.id

    ingress {
    description = "All Traffic on 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.my_cidr_block]
    }

    tags = {
        Name = local.sg_for_alb
    }
}
