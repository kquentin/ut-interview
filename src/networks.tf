## RESOURCES

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "subnet_a" {
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = false
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 0)
  availability_zone       = "${var.aws_region}a"
}

resource "aws_subnet" "subnet_b" {
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = false
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 1)
  availability_zone       = "${var.aws_region}b"
}
