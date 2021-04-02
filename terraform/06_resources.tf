resource "aws_s3_bucket" "b" {
    bucket = "20210402-bucket-tf"
    acl    = "private"

    tags = {
        Name        = "My Bucket 20210402"
        Environment = "Dev"
    }
}