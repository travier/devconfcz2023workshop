resource "aws_vpc" "devconf2023workshop" {
  cidr_block       = "172.31.0.0/16"

  tags = {
    Name = "devconfcz2023workshop"
  }
}

resource "aws_subnet" "devconf2023workshop" {
  vpc_id     = aws_vpc.devconf2023workshop.id
  cidr_block = "172.31.1.0/24"

  tags = {
    Name = "devconf2023workshop"
  }
}
