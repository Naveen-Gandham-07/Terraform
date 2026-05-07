resource "aws_instance" "web" {

  ami           = "ami-xxxxxxxx"
  # Change AMI ID based on your AWS region

  instance_type = "t2.micro"

  key_name      = "vscode"
  # Change key name as per your setup

  tags = {
    Name = "project-mainEC2"
  }

  root_block_device {
    volume_size = 20
    # We can give custom size here
  }
}


resource "aws_security_group" "devops_project_vcera" {

  name        = "devops-project-vcera"
  description = "Allow TLS inbound traffic"

  ingress = [
    for port in [22, 80, 443, 8080, 9000, 3000, 8081, 8082] : {

      description      = "inbound rules"
      from_port        = port
      to_port          = port
      protocol         = "tcp"

      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []

      prefix_list_ids  = []
      security_groups  = []

      self             = false
    }
  ]

  egress {

    from_port   = 0
    to_port     = 0
    protocol    = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-project-vcera"
  }
}