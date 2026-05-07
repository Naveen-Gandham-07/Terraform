variable "aws_region" {
    description = "The aws region to deploy resoucres"
    type = string
    default = "us-east-1"


}
variable "aws_profile" {
    description = "The AWS CLI Profile to use for authentication"
    type = string
    default = "naveen"  ## Give your profile name when your login with AWS configure -- profile
  
}