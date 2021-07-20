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


#################################
#           Crawler             # Un crawler par table
#################################

# Creation de crawler pour le bucket bronze
resource "aws_glue_crawler" "bronze_crawler" {
  database_name = aws_glue_catalog_database.aws_glue_catalog_bronze_database.name
  name          = "bronze_crawler"
  role          = aws_iam_role.aws_glue_env.arn

  s3_target {
    path = "s3://${aws_s3_bucket.lmu-bronze_bucket.bucket}"
  }
}


# Creation de crawler pour le bucket silver
resource "aws_glue_crawler" "silver_crawler" {
  database_name = aws_glue_catalog_database.aws_glue_catalog_silver_database.name
  name          = "silver_crawler"
  role          = aws_iam_role.aws_glue_env.arn

  s3_target {
    path = "s3://${aws_s3_bucket.lmu-silver_bucket.bucket}"
  }
}


# Creation de crawler pour le bucket gold
resource "aws_glue_crawler" "gold_crawler" {
  database_name = aws_glue_catalog_database.aws_glue_catalog_gold_database.name
  name          = "gold_crawler"
  role          = aws_iam_role.aws_glue_env.arn

  s3_target {
    path = "s3://${aws_s3_bucket.lmu-gold_bucket.bucket}"
  }
}



#################################
#           Dev Endpoint        #
#################################


resource "aws_glue_dev_endpoint" "dev_endpoint" {
  name            = "datalake-dev_endpoint"
  role_arn        = aws_iam_role.dev_endpoint.arn
  # worker_type     = "Standard"
  number_of_nodes = 2
  glue_version    = "1.0"
  public_key      = ""

}

resource "aws_iam_role" "dev_endpoint" {
  name               = "AWSGlueServiceRole-datalake"
  assume_role_policy = data.aws_iam_policy_document.dev_endpoint.json
}

data "aws_iam_policy_document" "dev_endpoint" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["glue.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "datalake-AWSGlueServiceRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
  role       = aws_iam_role.dev_endpoint.name
}
