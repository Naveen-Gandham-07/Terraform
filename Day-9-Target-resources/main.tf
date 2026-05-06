resource "aws_instance" "dependent" {
    ami = " "  ## Enter your AMI
    instance_type = ""  # Enter  you instance type
    key_name = ""  ## Enter you key Name
  
}

resource "aws_s3_bucket" "name" {
    bucket = "djehjsddn"
  
}

## you want to target one resource   terraform apply -target=aws_s3_bucket.dependet   will be created
## you want to target one resource   terraform destroy -target=aws_s3_bucket.dependet   will be deleted