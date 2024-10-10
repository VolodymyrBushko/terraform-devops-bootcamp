resource "aws_subnet" "private_subnet" {
  vpc_id                  = data.aws_vpc.default_vpc.id
  cidr_block              = "172.31.48.0/24"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "private_subnet"
  }
}