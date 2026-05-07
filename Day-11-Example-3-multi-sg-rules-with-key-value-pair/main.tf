provider "aws" {

}

locals {

  ingress_rules = {
    ssh       = { port = 22,   cidr = "203.0.113.0/24" }
    http      = { port = 80,   cidr = "0.0.0.0/0" }
    https     = { port = 443,  cidr = "0.0.0.0/0" }
    app       = { port = 8080, cidr = "10.0.0.0/16" }
    sonarqube = { port = 9000, cidr = "192.168.1.0/24" }
    rdp       = { port = 3389, cidr = "10.0.1.0/24" }
    grafana   = { port = 3000, cidr = "10.0.2.0/24" }
  }
}

resource "aws_security_group" "devops_project" {

  name        = "devops-project"
  description = "Dynamic Security Group"

  dynamic "ingress" {

    for_each = local.ingress_rules

    content {

      description = ingress.key

      from_port   = ingress.value.port
      to_port     = ingress.value.port

      protocol    = "tcp"

      cidr_blocks = [ingress.value.cidr]
    }
  }

  egress {

    from_port   = 0
    to_port     = 0

    protocol    = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-project"
  }
}