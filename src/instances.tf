## INSTANCES
### DB, CACHE

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group"

  subnet_ids = [
    aws_subnet.subnet_a.id,
    aws_subnet.subnet_b.id
  ]
}

resource "aws_elasticache_subnet_group" "cache_subnet_group" {
  name       = "cache-subnet-group"

  subnet_ids = [
    aws_subnet.subnet_a.id,
    aws_subnet.subnet_b.id
  ]
}

resource "aws_db_instance" "rds_instance" {
  allocated_storage    = 10
  engine               = "postgres"
  engine_version       = "16.1"
  instance_class       = "db.t3.micro"
  username             = "foo"
  password             = "barfoobar"
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [
    aws_security_group.sg_lambda_retrieve.id,
    aws_security_group.sg_lambda_cud.id,
    aws_security_group.sg_rds.id
  ]
}

resource "aws_elasticache_cluster" "cache" {
  cluster_id           = "cache"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  subnet_group_name    = aws_elasticache_subnet_group.cache_subnet_group.name

  security_group_ids = [
    aws_security_group.sg_lambda_retrieve.id,
    aws_security_group.sg_lambda_cud.id,
    aws_security_group.sg_elasticache.id
  ]
}

### API GATEWAY

resource "aws_apigatewayv2_api" "websocket_api" {
  name                       = "websocket_api"
  protocol_type              = "WEBSOCKET"
  route_selection_expression = "$request.body.action"
}

resource "aws_apigatewayv2_integration" "websocket_integration" {
  api_id             = aws_apigatewayv2_api.websocket_api.id
  integration_type   = "HTTP_PROXY"
  integration_method = "GET"
  integration_uri    = aws_lambda_function.lambda_retrieve.invoke_arn
}

resource "aws_apigatewayv2_api" "http_api" {
  name          = "http_api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "http_integration" {
  api_id             = aws_apigatewayv2_api.http_api.id
  integration_type   = "HTTP_PROXY"
  integration_method = "POST"
  integration_uri    = aws_lambda_function.lambda_cud.invoke_arn
}
