provider "aws" {
  
}
data "aws_subnet" "name" {
    filter {
      name = "tags:Name"
      values = [ "dev-subnet" ]    # give your existing subnet name
    }
  
}

data "aws_security_groups" "name" {
    filter {
      name = "tags:Name"
      values = [ " " ]     ## Give your existing SG name
    }
  
}

resource "aws_instance" "name" {
    ami = ""    # enter ami id
    instance_type = ""  # enter instance type
    key_name = ""   # enter key name
    subnet_id = data.aws_subnet.name.id
    vpc_security_group_ids = data.aws_security_groups.name.id

  
}
