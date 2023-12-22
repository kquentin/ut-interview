## BROKERS

resource "aws_sqs_queue" "sqs_queue" {
  name = "sqs-queue"
}

## LAMBDAS

resource "aws_lambda_function" "lambda_retrieve" {
  function_name = "lambda_retrieve"
  runtime       = "nodejs"
  handler       = "index.handler"
  role          = aws_iam_role.iam_lambda_retrieve_role.arn
  filename      = "xyz.zip" # s3

  environment {
    variables = {
      DB_HOST       = aws_db_instance.rds_instance.address,
      DB_USERNAME   = aws_db_instance.rds_instance.username,
      DB_PASSWORD   = aws_db_instance.rds_instance.password,
      REDIS_HOST    = aws_elasticache_cluster.cache.cluster_address,
      SQS_QUEUE_URL = aws_sqs_queue.sqs_queue.id
    }
  }
}

resource "aws_lambda_function" "lambda_cud" {
  function_name = "lambda_cud"
  runtime       = "nodejs"
  handler       = "index.handler"
  role          = aws_iam_role.iam_lambda_cud_role.arn
  filename      = "xyz.zip" # s3

  environment {
    variables = {
      DB_HOST       = aws_db_instance.rds_instance.address,
      DB_USERNAME   = aws_db_instance.rds_instance.username,
      DB_PASSWORD   = aws_db_instance.rds_instance.password,
      SQS_QUEUE_URL = aws_sqs_queue.sqs_queue.id
    }
  }
}

resource "aws_lambda_event_source_mapping" "lambda_retrieve_event_map" {
  event_source_arn = aws_sqs_queue.sqs_queue.arn
  function_name    = aws_lambda_function.lambda_retrieve.arn
}
