resource "aws_s3_bucket" "bucket" {
    bucket = "20210402-bucket-tf"
    acl    = "private"

    tags = {
        Name        = "My Bucket 20210402"
        Environment = "Dev"
    }
}


resource "aws_iam_role" "firehose_role" {
  name = "firehose_test_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


resource "aws_kinesis_firehose_delivery_stream" "test_stream" {
  name        = "20210402-kinesis-firehose-stream"
  destination = "s3"

  s3_configuration {
    role_arn   = aws_iam_role.firehose_role.arn
    bucket_arn = aws_s3_bucket.bucket.arn
  }
}