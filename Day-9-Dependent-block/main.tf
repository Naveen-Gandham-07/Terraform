provider "aws" {
  
}

resource "aws_s3_bucket" "bucket" {
    bucket = "naven-wuink"
  
}
resource "aws_instance" "web" {
    ami = "ami-0f559c3642608c138"
    instance_type = "t3.micro"
    key_name = "3-tier-project"
    depends_on = [ aws_s3_bucket.bucket ]

  
}