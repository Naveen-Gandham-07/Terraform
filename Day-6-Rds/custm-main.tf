resource "aws_db_instance" "mydb" {
  identifier         = "my-rds-db"
  engine             = "mysql"
  engine_version     = "8.0"
  instance_class     = "db.t3.micro"
  allocated_storage  = 20

  db_name  = "mydatabase"
  username = "admin"
  password = "Admin1234@"   # 🔐 Use secrets manager in real projects

  db_subnet_group_name   = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  publicly_accessible = true
  skip_final_snapshot = true
}