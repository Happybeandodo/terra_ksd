# 19_rds
resource "aws_db_instance" "jiwon_mydb" {
  allocated_storage      = var.db_storage
  storage_type           = "gp2"
  engine                 = var.mysql
  engine_version         = "8.0"
  instance_class         = "db.${var.instance_type}"
  name                   = var.db_name
  identifier             = var.db_name
  username               = var.db_username
  password               = var.db_pw
  parameter_group_name   = "default.mysql8.0"
  availability_zone      = "${var.region}${var.ava_zone[0]}"
  db_subnet_group_name   = aws_db_subnet_group.jiwon_dbsg.id
  vpc_security_group_ids = [aws_security_group.jiwon_sg.id]
  skip_final_snapshot    = true
  tags = {
    "Name" = "${var.name}-db"
  }
}
resource "aws_db_subnet_group" "jiwon_dbsg" {
  name       = "${var.name}-dbsg"
  subnet_ids = [aws_subnet.jiwon_pridb[0].id,aws_subnet.jiwon_pridb[1].id]

}
