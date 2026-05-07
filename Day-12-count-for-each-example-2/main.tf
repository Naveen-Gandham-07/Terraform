variable "env" {
    type = list(string)
    default = [ "dev","prod"]
  
}

resource "aws_instance" "name" {
    ami = "ami-07860a2d7eb515d9a"
    instance_type = "t2.micro"
    count = length(var.env)
    # tags = {
    #   Name = "dev"
    # }
  tags = {
      Name = var.env[count.index]
    }
}