terraform {
  backend "s3" {
    bucket = "359252437790-us-east-1-terraform-state"
    key    = "my-terrafom-test-bucket-coe-backend-test/bucket.tfstate"
    dynamodb_table = "Tap-statefile-lock"
    region = "us-east-1"
  }
}
