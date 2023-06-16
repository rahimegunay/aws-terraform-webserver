resource "aws_security_group" "aws_cloud2" {
  name        = "aws-cloud2-sg"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.aws_cloud2.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["86.14.208.120/32"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["86.14.208.120/32"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "aws-cloud2"
  }
}

resource "aws_security_group" "aws_cloud2_lb" {
  name        = "aws-cloud2-lb"
  description = "Allow outbound traffic"
  vpc_id      = aws_vpc.aws_cloud2.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}