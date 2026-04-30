terraform {
  backend "s3" {
    bucket = "naveen-test-buc"
    key    = "terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "terraform-state-lock-dynamodb"
    encrypt = true
  }
}
