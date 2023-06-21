
resource "aws_key_pair" "my_web" {
  key_name   = "as-cloud2-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDWFgluUIqZxH5cU6+CrnkZ/+zuQqdlp1cSfbk2KxJkObKws3mi8i8hLMkVtXgVATs3iyuiM4xJzRKkphQzhPT8j7OEesiDs1bhD0fpJH/CLAlMWV9mFPAHzn41KeUO5i0VRrhDm9Bx5y0z+iicQYw3kaiX7isl5h6AGXa/4nH9aMg/ogoUo8uC7VAK17b0vnoeYXe6AfqJNNTEsLMVH7K8Xte+S/9YHqMe4xGz3t/URQaPRP7it15K809mbYIXsvtza40R8s35nGQ+2wHsRYD4xXtlj46en9l3nvzyhpv8k1FftKEnAwXt4t7HGnv9njCC49NMKD8MmeZZftRWV791sBrjcwf/WgGr2P+aSEAbJLT4nbcyyAwSQ1s3uZIHyLKk8PtT+B0T9KdvZLf7aELhh2gw1e3XeGb1qAJincCy80a2bA1iDPPS7VC+Blx9IkqTvVC2UBTlAXRGEWiQRSabIMVf4IVcmp8+atLs6EyFmyWi71g4JBoILCAsKuJz3TU= rgceylan@Rahimes-MacBook-Pro.local"
}

resource "aws_launch_template" "aws_cloud2_temp" {
  name_prefix            = "aws_cloud2_temp"
  image_id               = data.aws_ami.ubuntu.id
  key_name               = aws_key_pair.my_web.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.aws_cloud2.id, aws_security_group.aws_cloud2_lb.id]
  user_data              = filebase64("${path.module}/userdata.tpl")
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_autoscaling_group" "asg" {
  desired_capacity    = 1
  max_size            = 2
  min_size            = 1
  vpc_zone_identifier = [aws_subnet.my_public2.id]
  target_group_arns   = [aws_lb_target_group.aws_cloud2_tg.arn]

  launch_template {
    id      = aws_launch_template.aws_cloud2_temp.id
    version = "$Latest"
  }
}


resource "aws_lb_target_group" "aws_cloud2_tg" {
  name     = "aws-loud2-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.aws_cloud2.id
}


resource "aws_lb" "aws_cloud2_lb" {
  name               = "aws-cloud2-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.aws_cloud2_lb.id]
  subnets = [
    aws_subnet.my_public1.id,
    aws_subnet.my_public2.id,
  ]

  enable_deletion_protection = false


  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener" "aws_cloud2_listener" {
  load_balancer_arn = aws_lb.aws_cloud2_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.aws_cloud2_tg.arn
  }
}