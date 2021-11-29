# 15_ami
resource "aws_ami_from_instance" "jiwon_ami" {
  name               = "${var.name}-ami"
  source_instance_id = aws_instance.jiwon_web.id
  depends_on = [
    aws_instance.jiwon_web
  ]
}


# 16_lacf
resource "aws_launch_configuration" "jiwon_lacf" {
  name                 = "${var.name}-lacf"
  image_id             = aws_ami_from_instance.jiwon_ami.id
  instance_type        = var.instance_type
  iam_instance_profile = "admin_role"
  security_groups      = [aws_security_group.jiwon_sg.id]
  key_name             = var.key
  user_data            = <<-EOF
                  #!/bin/bash
                  systemctl start httpd
                  systemctl enable httpd
                  EOF
}


# 17_atsg
resource "aws_placement_group" "jiwon_pg" {
  name     = "${var.name}-pg"
  strategy = var.pg_type

}

resource "aws_autoscaling_group" "jiwon_atsg" {
  name                      = "${var.name}-atsg"
  min_size                  = var.as_min_size
  max_size                  = var.as_max_size
  health_check_type         = var.health_check_type
  desired_capacity          = var.as_desired_capacity
  force_delete              = true
  launch_configuration      = aws_launch_configuration.jiwon_lacf.name
  #placement_group           = aws_placement_group.jiwon_pg.id
  vpc_zone_identifier       = [aws_subnet.jiwon_pub[0].id, aws_subnet.jiwon_pub[1].id]
}


# 18_asatt
resource "aws_autoscaling_attachment" "jiwon_asatt" {
    autoscaling_group_name = aws_autoscaling_group.jiwon_atsg.id
    alb_target_group_arn = aws_lb_target_group.jiwon_albtg.arn
  
}