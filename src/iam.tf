## DATA

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

## IAM
### LAMBDA RETRIEVE

resource "aws_iam_role" "iam_lambda_retrieve_role" {
  name               = "iam_lambda_retrieve_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda_basic_retrieve_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.iam_lambda_retrieve_role.name
}

resource "aws_iam_role_policy_attachment" "lambda_rds_retrieve_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
  role       = aws_iam_role.iam_lambda_retrieve_role.name
}

resource "aws_iam_role_policy_attachment" "lambda_sqs_retrieve_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
  role       = aws_iam_role.iam_lambda_retrieve_role.name
}

resource "aws_iam_role_policy_attachment" "lambda_elasticache_retrieve_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonElastiCacheFullAccess"
  role       = aws_iam_role.iam_lambda_retrieve_role.name
}

### LAMBDA CUD

resource "aws_iam_role" "iam_lambda_cud_role" {
  name               = "iam_lambda_cud_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda_basic_cud_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.iam_lambda_cud_role.name
}

resource "aws_iam_role_policy_attachment" "lambda_rds_cud_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
  role       = aws_iam_role.iam_lambda_cud_role.name
}

resource "aws_iam_role_policy_attachment" "lambda_sqs_cud_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
  role       = aws_iam_role.iam_lambda_cud_role.name
}
