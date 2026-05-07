resource "aws_security_group" "devops_project_vcera" {

  name        = "devops-project-vcera"
  description = "Custom inbound rules"

  # SSH
  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"

    cidr_blocks = ["49.xx.xx.xx/32"]
    # Your personal public IP
  }

  # HTTP
  ingress {
    description = "HTTP Access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS
  ingress {
    description = "HTTPS Access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  # Jenkins
  ingress {
    description = "Jenkins Access"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"

    cidr_blocks = ["192.168.1.0/24"]
  }

  # SonarQube
  ingress {
    description = "SonarQube Access"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"

    cidr_blocks = ["10.0.0.0/16"]
  }

  # Outbound
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