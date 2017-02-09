# Create S3 bucket that will be used to store terraform remote state
# Make sure that versioning is enabled for bucket

resource "aws_s3_bucket" "tf-remote-state-bucket" {
  bucket = "mybucket-w4-workshop"
  acl = "private"
  versioning {
    enabled = true
  }
}
