resource "aws_db_subnet_group" "db_subnet" {
  name       = "main-db-subnet"
  subnet_ids = [
    aws_subnet.subnet1.id,
    aws_subnet.subnet2.id
  ]

  tags = {
    Name = "db-subnet-group"
  }
}