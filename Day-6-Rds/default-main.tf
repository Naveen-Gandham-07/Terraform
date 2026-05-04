

resource "aws_db_instance" "default" {
  identifier        = "default-rds-db"
  engine            = "mysql"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = "mydb"
  username = "admin"
  password = "Admin1234@"   # ⚠️ only for practice

  publicly_accessible = true
  skip_final_snapshot = true
}