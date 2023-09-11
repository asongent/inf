terraform {
  backend "s3" {
    bucket = "" # s3 remote state bucket name
    key    = "" # path to state file should be unique per terraform directory
    dynamodb_table = "fred-statefile-lock"
    region = "" # region where s3 bucket was created
  }
}
