resource "aws_instance" "devconfcz2023workshop" {
  ami           = "ami-016a79745fc97446a"
  instance_type = "m6i.4xlarge"
  key_name      = "travier"

  tags = {
    Name = "devconfcz2023workshop"
  }

  vpc_security_group_ids = [aws_security_group.devconfcz2023workshop.id]
  subnet_id = aws_subnet.devconf2023workshop.id

  root_block_device {
    volume_size = "100"
    volume_type = "gp3"
  }

  user_data_base64 = "eyJpZ25pdGlvbiI6eyJjb25maWciOnsicmVwbGFjZSI6eyJzb3VyY2UiOiJodHRwczovL2Zjb3Muc2lvc20uZnIvOWNiOTc4NmFhN2Q4MzA5ODA1M2YxNzYwNTY3MWI5MWRiNjZhZTFjOWM3ZmQ1MTBiNzhmYTFiNzhjZTRjMzA2Zi5pZ24ifX0sInZlcnNpb24iOiIzLjMuMCJ9fQo="
}
