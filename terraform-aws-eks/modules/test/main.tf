resource "aws_s3_bucket" "test_bucket" {
  bucket = var.bucket_name
  acl    = "private"

  logging {
    target_bucket = "359252437790-us-east-1-terraform-state-logs"
    target_prefix = "test-log/local.bucket_id"
  }

  tags = {
    provisioner = "Terraform"
    Name       = var.bucket_name
    Contact = var.email
    Resource_POC = var.name
    Application = "Terraform - test"
    Description = "test-bucket to test terraform backend"
  }
}
