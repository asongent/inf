provider "aws" {
  region  = var.region
}
module "s3_bucket" {
  source         = "../modules/test"
  bucket_name    = var.s3_bucket_name
  email          = var.s3_bucket_tag_email
  name           = var.s3_bucket_tag_name
}
