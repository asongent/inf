variable "region" {
  description = "region for aws provider"
  default = "us-east-1"
}
variable "s3_bucket_name" {
  type    = string
  description = "bucket name to be created this should be a unique name"
  default = ""
}
# for below variables 
# create a terraform.tfvars file in the current directory and include the values for these there
# reason is so to not commit personal information to source control
# format: terraform.tfvars => s3_bucket_tag_email = "your email"
# format: terraform.tfvars => s3_bucket_tag_name = "your name"
variable "s3_bucket_tag_email" {
    description = "email to associate with tag contact"
}
variable "s3_bucket_tag_name" {
    description = "name of person of contact"
}