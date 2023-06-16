resource "aws_vpc" "aws_cloud2" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "aws_cloud2"
  }
}


resource "aws_subnet" "my_public1" {
  vpc_id                  = aws_vpc.aws_cloud2.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "my_public1"
  }

}
resource "aws_subnet" "my_public2" {
  vpc_id                  = aws_vpc.aws_cloud2.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "eu-west-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "my_public2"
  }
}


resource "aws_internet_gateway_attachment" "vpc-gw-attachment" {
  internet_gateway_id = aws_internet_gateway.vpc-gw.id
  vpc_id              = aws_vpc.aws_cloud2.id
}

resource "aws_internet_gateway" "vpc-gw" {
}
resource "aws_route" "aws_cloud2_route" {
  route_table_id         = aws_vpc.aws_cloud2.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc-gw.id
}