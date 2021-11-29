# 01_vpc(00_ssh + 01_main + 02_sub)
# 00_ssh
resource "aws_key_pair" "jiwon-key" {
  key_name   = var.key
  public_key = file("../../.ssh/jiwon-key.pub")
}
provider "aws" {
  region = var.region
}

# 01_main
resource "aws_vpc" "jiwon_vpc" {
  cidr_block           = var.cidr_main
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    "Name" = "${var.name}-vpc"
  }
}

# 02_sub
#1 public subnet
resource "aws_subnet" "jiwon_pub" {
  count             = length(var.pub_sub) #variable에 있는 public subnet의 값이 몇 개 인지 보고 자동으로 할당
  vpc_id            = aws_vpc.jiwon_vpc.id
  cidr_block        = var.pub_sub[count.index]                    #index 0 -> 10.0.0.0/24
  availability_zone = "${var.region}${var.ava_zone[count.index]}" # -> index 0일 때 a
  tags = {
    "Name" = "${var.name}-pub${var.ava_zone[count.index]}"
  }
}

#3 private subnet
resource "aws_subnet" "jiwon_pri" {
  count             = length(var.pri_sub)
  vpc_id            = aws_vpc.jiwon_vpc.id
  cidr_block        = var.pri_sub[count.index]
  availability_zone = "${var.region}${var.ava_zone[count.index]}"
  tags = {
    "Name" = "${var.name}-pri${var.ava_zone[count.index]}"
  }

}

#5 db subnet
resource "aws_subnet" "jiwon_pridb" {
  # 2개 이상의 리소스 쓸 때 count meta argument 사용
  count             = length(var.pri_subdb)
  vpc_id            = aws_vpc.jiwon_vpc.id
  cidr_block        = var.pri_subdb[count.index]
  availability_zone = "${var.region}${var.ava_zone[count.index]}"
  tags = {
    "Name" = "${var.name}-pridb${var.ava_zone[count.index]}"
  }

}


