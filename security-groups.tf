resource "aws_security_group" "devconfcz2023workshop" {
  name        = "devconfcz2023workshop"
  description = "Allow SSH inbound traffic only"
  vpc_id      = aws_vpc.devconf2023workshop.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.devconf2023workshop.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devconfcz2023workshop"
  }
}
