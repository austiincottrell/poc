resource "aws_lb" "ALB" {
    load_balancer_type = "application"
    subnets            = [aws_subnet.subnet[0].id, aws_subnet.subnet[1].id,aws_subnet.subnet[2].id,aws_subnet.subnet[3].id]
    security_groups    = [aws_security_group.ALB_security_group.id]

    access_logs {
        bucket = aws_s3_bucket.access_logs.bucket
        prefix = "alb_logs"
    }

    tags = {
        Name = local.alb_name
    }

    depends_on = [aws_s3_bucket.access_logs]
}

resource "aws_lb_target_group" "target_group" {
    port     = 80
    protocol = "HTTP"
    vpc_id   = aws_vpc.secure_vpc.id
}

resource "aws_lb_target_group_attachment" "target_vm" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = aws_instance.amazonlinux_vm_private.id
  port             = 80
}

resource "aws_lb_listener" "listen" {
    load_balancer_arn = aws_lb.ALB.arn
    port              = 80
    protocol          = "HTTP"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.target_group.arn
    }
}