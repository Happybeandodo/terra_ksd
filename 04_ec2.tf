# 09_sg
resource "aws_security_group" "jiwon_sg" {
  name        = "${var.name}_sg"
  description = "HTTP_ICMP_SQL"
  vpc_id      = aws_vpc.jiwon_vpc.id

  ingress = [
    {
      description      = var.ssh
      from_port        = var.port_ssh
      to_port          = var.port_ssh
      protocol         = var.pro_tcp
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.cidr_route]
      prefix_list_ids  = var.null
      security_groups  = var.null
      self             = var.null

    },
    {
      description      = var.http
      from_port        = var.port_http
      to_port          = var.port_http
      protocol         = var.pro_tcp
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.IPv6]
      prefix_list_ids  = var.null
      security_groups  = var.null
      self             = var.null
    },
    {
      description      = var.icmp
      from_port        = var.minus
      to_port          = var.minus
      protocol         = var.pro_icmp
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.IPv6]
      prefix_list_ids  = var.null
      security_groups  = var.null
      self             = var.null
    },
    {
      description      = var.mysql
      from_port        = var.port_mysql
      to_port          = var.port_mysql
      protocol         = var.pro_tcp
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.IPv6]
      prefix_list_ids  = var.null
      security_groups  = var.null
      self             = var.null
    }
  ]

  egress = [
    {
      description      = "all"
      from_port        = var.port_zero
      to_port          = var.port_zero
      protocol         = var.minus
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.IPv6]
      prefix_list_ids  = var.null
      security_groups  = var.null
      self             = var.null
    }
  ]
  tags = {
    "Name" = "${var.name}_sg"
  }
}



# 10_ec2
data "aws_ami" "amzn" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "jiwon_web" {
  ami                    = data.aws_ami.amzn.id
  instance_type          = var.instance_type
  key_name               = var.key
  vpc_security_group_ids = [aws_security_group.jiwon_sg.id]
  availability_zone      = "${var.region}${var.ava_zone[0]}"
  private_ip             = var.private_ip
  subnet_id              = aws_subnet.jiwon_pub[0].id
  user_data              = file("./install.sh")
  
  tags = {
    "Name" = "${var.name}-web"
  }
}

resource "aws_eip" "jion_web_ip" {
  vpc                       = true
  instance                  = aws_instance.jiwon_web.id
  associate_with_private_ip = var.private_ip
  depends_on = [
    aws_internet_gateway.jiwon_ig
  ]

}

output "public_ip" {
  value = aws_instance.jiwon_web.public_ip
}
