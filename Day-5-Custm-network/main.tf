# creation of vpc
resource "aws_vpc" "dev" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "custum_vpc"
    }
  
}

# creation of subnet-pub
resource "aws_subnet" "pub_sub" {
    vpc_id = aws_vpc.dev.id
    cidr_block = "10.0.0.0/24"
    map_public_ip_on_launch = true
    tags = {
      Name = "public_subnet"
    }
  
}

# creation private-subnet
resource "aws_subnet" "private_sub" {
    vpc_id = aws_vpc.dev.id
    cidr_block = "10.0.1.0/24"
    tags = {
      Name = "prt-sub"
    }
  
}

# creation of internet-gate-way
resource "aws_internet_gateway" "IGW" {
    vpc_id = aws_vpc.dev.id
    tags = {
      Name = "pub_igw"
    }
  
}

# creataion of route table pub
resource "aws_route_table" "pub-rt" {
    vpc_id = aws_vpc.dev.id
    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.IGW.id
    }
}

# creation of route-table-assocation-pub
resource "aws_route_table_association" "pub_route" {
    subnet_id = aws_subnet.pub_sub.id
    route_table_id = aws_route_table.pub-rt.id
  
}

# creation of elastic ip for nat-gat-way
resource "aws_eip" "nat-eip" {
    domain = "vpc"
    tags = {
      Name = "aws-eip"
    }
}

# creation of nat-gate-way
resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.nat-eip.id
    subnet_id = aws_subnet.pub_sub.id
    depends_on = [ aws_internet_gateway.IGW ]
  
}

# creation of route table for -pvt
resource "aws_route_table" "prt" {
    vpc_id = aws_vpc.dev.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat.id
    }
    tags = {
      Name="prvt-rt"
    }
  
}

# creation of route-table-asssocation for pvt
resource "aws_route_table_association" "prvt-ass" {
    subnet_id = aws_subnet.private_sub.id
    route_table_id = aws_route_table.pub-rt.id
  
}

# Creation Security Group
resource "aws_security_group" "dev_sg" {
  name   = "allow_tls"
  vpc_id = aws_vpc.dev_vpc.id
  tags = {
    Name = "dev-sg"
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Creation of server
resource "aws_instance" "dev_server" {
  ami                    = "ami-08a6efd148b1f7504"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.dev_subnet1.id
  vpc_security_group_ids = [aws_security_group.dev_sg.id]
  tags = {
    Name = "dev-server"
  }
}

# creation of resource
resource "aws_instance" "pub" {
    ami = "ami-0f559c3642608c138"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.pub_sub.id
    key_name = "3-tier-project"
    security_groups = [ aws_security_group.dev_sg.id ]
    associate_public_ip_address = true
    
  
}
resource "aws_instance" "prt-server" {
    ami = "ami-0f559c3642608c138"
    instance_type = "t3.micro"
    key_name = "3-tier-project"
    subnet_id = aws_subnet.private_sub.id
    security_groups = [ aws_security_group.dev_sg.id ]
  
}