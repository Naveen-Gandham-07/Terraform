resource "aws_instance" "name" {
    ami = "ami-0f559c3642608c138"
    instance_type = "t3.micro"
    key_name = "3-tier-project"
    tags = {
      Name = "dev"
    }
  
}