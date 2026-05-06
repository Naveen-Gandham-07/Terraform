provider "aws" {
  
}

data "aws_ami" "amzlinux" {
    most_recent = true
    owners = [ "self" ]
    filter {
      name = "name"
      values = [ "fronend" ]   ## Give your AMI name
    }
  
}

resource "aws_instance" "name" {
    ami = data.aws_ami.amzlinux.id
    instance_type = ""
    key_name = ""
  
}