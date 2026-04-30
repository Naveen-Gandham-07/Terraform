terraform {
  backend "s3" {
    bucket = "naveen-test-buc"
    key    = "day-5/terraform.tfstate"
    region = "ap-south-1"
  }
}