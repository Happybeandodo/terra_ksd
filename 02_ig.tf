#03_ig
resource "aws_internet_gateway" "jiwon_ig" {
    vpc_id = aws_vpc.jiwon_vpc.id

    tags = {
      Name = "${var.name}-ig"
    }
  
}

#04_rt
resource "aws_route_table" "jiwon_rt" {
    vpc_id = aws_vpc.jiwon_vpc.id

    route {
        cidr_block = var.cidr_route
        gateway_id = aws_internet_gateway.jiwon_ig.id
    }
    tags = {
        "Name" = "${var.name}-rt"
    }
}

#05_rtsubass
resource "aws_route_table_association" "jiwon_pub" {
    count = length(var.pub_sub)
    subnet_id = aws_subnet.jiwon_pub[count.index].id
    route_table_id = aws_route_table.jiwon_rt.id
}