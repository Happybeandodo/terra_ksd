#06_natgw
resource "aws_eip" "jiwon_ngw_ip" {
  vpc = true
}

resource "aws_nat_gateway" "jiwon_ngw" {
  allocation_id = aws_eip.jiwon_ngw_ip.id
  subnet_id     = aws_subnet.jiwon_pub[0].id
  tags = {
    "Name" = "${var.name}-ngw"
  }
}
# 07_ngwrt
resource "aws_route_table" "jiwon_ngwrt" {
    vpc_id = aws_vpc.jiwon_vpc.id
    
    route {
        cidr_block = var.cidr_nat
        gateway_id = aws_nat_gateway.jiwon_ngw.id
    } 
    tags = {
      "Name" = "${var.name}-ngwrt"
    }  
}

#08_ngwbass
resource "aws_route_table_association" "jiwon_ngwass_pri" {
    count = length(var.pri_sub)
    subnet_id = aws_subnet.jiwon_pri[count.index].id
    route_table_id = aws_route_table.jiwon_ngwrt.id
}

resource "aws_route_table_association" "jiwon_ngwass_pridb" {
    count = length(var.pri_subdb)
    subnet_id = aws_subnet.jiwon_pridb[count.index].id
    route_table_id = aws_route_table.jiwon_ngwrt.id
}