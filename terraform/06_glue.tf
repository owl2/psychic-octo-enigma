# Creation des databases pour le datalake
resource "aws_glue_catalog_database" "aws_glue_catalog_bronze_database" {
  name = "datalake-bronze"
}

resource "aws_glue_catalog_database" "aws_glue_catalog_silver_database" {
  name = "datalake-silver"
}

resource "aws_glue_catalog_database" "aws_glue_catalog_gold_database" {
  name = "datalake-gold"
}

# Creation d'un crawler se sourcant sur un bucket S3
resource "aws_glue_crawler" "bronze_crawler" {
  database_name = aws_glue_catalog_database.aws_glue_catalog_bronze_database.name
  name          = "bronze_crawler"
  role          = aws_iam_role.aws_glue_env.arn

  s3_target {
    path = "s3://${aws_s3_bucket.lmu-bronze_bucket.bucket}"
  }
}
