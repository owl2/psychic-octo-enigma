# Bucket for external source simulation
resource "aws_s3_bucket" "lmu-external-sources" {
  bucket = "lmu-external-sources"
  acl    = "private"

    tags = {
    Name        = "lmu-external-sources"
  }
}


# Bucket for the raw data
resource "aws_s3_bucket" "lmu-bronze_bucket" {
  bucket = "lmu-datalake-bronze"
  acl    = "private"

  tags = {
    Name        = "lmu-datalake-bronze"
  }
}


# Bucket for the transformed data
resource "aws_s3_bucket" "lmu-silver_bucket" {
  bucket = "lmu-datalake-silver"
  acl    = "private"

  tags = {
    Name        = "lmu-datalake-silver"
  }
}


# Bucket for the enriched data
resource "aws_s3_bucket" "lmu-gold_bucket" {
  bucket = "lmu-datalake-gold"
  acl    = "private"

  tags = {
    Name        = "lmu-datalake-gold"
  }
}
