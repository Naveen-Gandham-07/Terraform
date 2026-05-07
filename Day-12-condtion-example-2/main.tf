provider "aws" {
  
}
variable "create_bucket" {
  type    = bool
  default = false
}

resource "aws_s3_bucket" "example" {
  count  = var.create_bucket ? 1 : 0
  bucket = "my-terraform-example"
}