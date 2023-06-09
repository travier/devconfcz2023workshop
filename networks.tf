resource "aws_vpc" "vpc" {
  provider             = aws.region
  cidr_block           = "172.31.0.0/16"

  tags = {
    Name = "devconfcz2023workshop"
  }
}

resource "aws_internet_gateway" "igw" {
  provider = aws.region
  vpc_id   = aws_vpc.vpc.id
}

data "aws_availability_zones" "azs" {
  provider = aws.region
  state    = "available"
}


resource "aws_subnet" "subnet_1" {
  provider                = aws.region
  availability_zone       = element(data.aws_availability_zones.azs.names, 0)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "172.31.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "devconf2023workshop_1"
  }
}

resource "aws_subnet" "subnet_2" {
  provider                = aws.region
  availability_zone       = element(data.aws_availability_zones.azs.names, 1)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "172.31.2.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "devconf2023workshop_2"
  }
}

resource "aws_subnet" "subnet_3" {
  provider                = aws.region
  availability_zone       = element(data.aws_availability_zones.azs.names, 2)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "172.31.3.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "devconf2023workshop_3"
  }
}

resource "aws_route_table" "internet_route" {
  provider = aws.region
  vpc_id   = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  lifecycle {
    ignore_changes = all
  }
  tags = {
    Name = "devconf2023workshop"
  }
}

resource "aws_main_route_table_association" "set-main-default-rt-assoc" {
  provider       = aws.region
  vpc_id         = aws_vpc.vpc.id
  route_table_id = aws_route_table.internet_route.id
}
