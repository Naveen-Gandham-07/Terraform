resource "aws_instance" "provider-1" {
  ami="ami-07860a2d7eb515d9a" 
  instance_type = "t2.micro"

}

resource "aws_s3_bucket" "provider-2" {
    bucket = "tybuwbdsjbcscj"
    provider = aws.oregon
  
}

provider "aws" {
    region = "ap-south-1"
  
}
provider "aws" {
    region = "us-east-1"
    alias = "provider-2"
  
}