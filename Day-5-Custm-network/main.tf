resource "aws_vpc" "dev" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "custum_vpc"
    }
  
}
resource "aws_subnet" "pub_sub" {
    vpc_id = aws_vpc.dev.id
    cidr_block = "10.0.0.0/24"
    map_public_ip_on_launch = true
    tags = {
      Name = "public_subnet"
    }
  
}

resource "aws_subnet" "private_sub" {
    vpc_id = aws_vpc.dev.id
    cidr_block = "10.0.1.0/24"
    tags = {
      Name = "prt-sub"
    }
  
}
resource "aws_internet_gateway" "IGW" {
    vpc_id = aws_vpc.dev.id
    tags = {
      Name = "pub_igw"
    }
  
}
resource "aws_route_table" "pub-rt" {
    vpc_id = aws_vpc.dev.id
    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.IGW.id
    }
}
resource "aws_route_table_association" "pub_route" {
    subnet_id = aws_subnet.pub_sub.id
    route_table_id = aws_route_table.pub-rt.id
  
}

resource "aws_eip" "nat-eip" {
    domain = "vpc"
    tags = {
      Name = "aws-eip"
    }
}

resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.nat-eip.id
    subnet_id = aws_subnet.pub_sub.id
    depends_on = [ aws_internet_gateway.IGW ]
  
}

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
resource "aws_route_table_association" "prvt-ass" {
    subnet_id = aws_subnet.private_sub.id
    route_table_id = aws_route_table.pub-rt.id
  
}

resource "aws_instance" "pub" {
    ami = "ami-0f559c3642608c138"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.pub_sub.id
    key_name = "3-tier-project"
    associate_public_ip_address = true
    
  
}
resource "aws_instance" "prt-server" {
    ami = "ami-0f559c3642608c138"
    instance_type = "t3.micro"
    key_name = "3-tier-project"
    subnet_id = aws_subnet.private_sub.id
  
}