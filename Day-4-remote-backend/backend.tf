terraform {
  backend "s3" {
    bucket = "naveen-test-buc"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}
