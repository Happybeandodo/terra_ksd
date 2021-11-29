variable "region" {
  type    = string
  default = "ap-northeast-2"
}
variable "ava_zone" {
  default = ["a", "c"]
}
variable "name" {
  type    = string
  default = "jiwon"
}

variable "key" {
  type    = string
  default = "jiwon-key"
}

variable "cidr_main" {
  type    = string
  default = "10.0.0.0/16"
}

variable "pub_sub" {
  default = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "pri_sub" {
  default = ["10.0.2.0/24", "10.0.3.0/24"]
}

variable "pri_subdb" {
  default = ["10.0.4.0/24", "10.0.5.0/24"]
}

variable "cidr_route" {
  type    = string
  default = "0.0.0.0/0"
}
variable "cidr_nat" {
  type    = string
  default = "0.0.0.0/0"
}

variable "private_ip" {
  type    = string
  default = "10.0.0.11"

}
variable "IPv6" {
  type    = string
  default = "::/0"

}
variable "ssh" {
  type    = string
  default = "ssh"
}

variable "http" {
  type    = string
  default = "http"
}

variable "HTTP" {
  type    = string
  default = "HTTP"

}
variable "icmp" {
  type    = string
  default = "icmp"
}

variable "mysql" {
  type    = string
  default = "mysql"
}

variable "port_ssh" {
  type    = number
  default = 22
}

variable "port_http" {
  type    = number
  default = 80
}

variable "port_mysql" {
  type    = number
  default = 3306
}

variable "port_zero" {
  type    = number
  default = 0
}

variable "minus" {
  default = -1
}

variable "pro_tcp" {
  type    = string
  default = "tcp"
}

variable "pro_icmp" {
  type    = string
  default = "icmp"
}

variable "pro_udp" {
  type    = string
  default = "udp"
}

variable "null" {
  default = null
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "healthy_threshold" {
  type    = number
  default = 3
}

variable "interval" {
  type    = number
  default = 5
}

variable "matcher" {
  type    = string
  default = "200"
}

variable "path" {
  type    = string
  default = "/health.html"
}

variable "timeout" {
  type    = number
  default = 2
}

variable "unhealthy_threshold" {
  type    = number
  default = 2
}

variable "pg_type" {
  type    = string
  default = "cluster"
}

variable "as_min_size" {
  type    = number
  default = 2
}

variable "as_max_size" {
  type    = number
  default = 10
}

variable "health_check_type" {
  type    = string
  default = "EC2"
}

variable "as_desired_capacity" {
  type    = number
  default = 2
}

variable "db_storage" {
  type = number
  default = 20  
}
variable "db_pw" {
  type    = string
  default = "Qptmvlswldnjs_77"
}

variable "db_username" {
  type    = string
  default = "admin"
}

variable "db_name" {
  type    = string
  default = "mydb"
}
