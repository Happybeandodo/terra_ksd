# 11_alb
resource "aws_lb" "jiwon_alb" {
  name               = "${var.name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.jiwon_sg.id]
  subnets            = [aws_subnet.jiwon_pub[0].id, aws_subnet.jiwon_pub[1].id]
  tags = {
    "Name" = "${var.name}-alb"
  }
}

output "dns_name" {
  value = aws_lb.jiwon_alb.dns_name
}

# 12_albtg
resource "aws_lb_target_group" "jiwon_albtg" {
  name     = "${var.name}-albtg"
  port     = var.port_http
  protocol = var.HTTP
  vpc_id   = aws_vpc.jiwon_vpc.id

  health_check {
    enabled             = true
    healthy_threshold   = var.healthy_threshold
    interval            = var.interval
    matcher             = var.matcher
    path                = var.path
    port                = "traffic-port"
    protocol            = var.HTTP
    timeout             = var.timeout
    unhealthy_threshold = var.unhealthy_threshold
  }

}

# 13_alblis
resource "aws_lb_listener" "jiwon_albtlis" {
    load_balancer_arn = aws_lb.jiwon_alb.arn
    port = var.port_http
    protocol = var.HTTP

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.jiwon_albtg.arn
    }
  
}

# 14_albtgatt
# 꼭 필요하지 않은 구문
resource "aws_lb_target_group_attachment" "jiwon_albtagtt" {
  target_group_arn = aws_lb_target_group.jiwon_albtg.arn
  target_id        = aws_instance.jiwon_web.id  
  port             = var.port_http
}
