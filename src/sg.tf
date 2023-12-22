## SECURITY GROUPS
### OUTBOUND RULES

resource "aws_security_group" "sg_lambda_retrieve" {
  name        = "sg_lambda_retrieve"
  vpc_id      = aws_vpc.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [
      aws_subnet.subnet_a.cidr_block,
      aws_subnet.subnet_b.cidr_block,
    ]
  }
}

resource "aws_security_group" "sg_lambda_cud" {
  name        = "sg_lambda_cud"
  vpc_id      = aws_vpc.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [
      aws_subnet.subnet_a.cidr_block,
      aws_subnet.subnet_b.cidr_block,
    ]  
  }
}

### INBOUND RULES

resource "aws_security_group" "sg_rds" {
  name        = "sg_rds"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port          = 5432
    to_port            = 5432
    protocol           = "tcp"
  }
}

resource "aws_security_group" "sg_elasticache" {
  name        = "sg_elasticache"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port          = 6379
    to_port            = 6379
    protocol           = "tcp"
  }
}
