provider "aws" {
  region  = var.region
  profile = var.profile
}

resource "aws_launch_template" "base" {
  name                                 = "base"
  image_id                             = data.aws_ami.amazon_linux2.id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = var.on_demand_instance_type
  iam_instance_profile {
    arn = aws_iam_instance_profile.profile.arn
  }
  user_data = filebase64(var.user_data_filename)
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "base"
    }
  }
  tag_specifications {
    resource_type = "volume"
    tags = {
      Name = "base"
    }
  }
  tag_specifications {
    resource_type = "network-interface"
    tags = {
      Name = "base"
    }
  }
}




resource "aws_iam_role" "instance" {
  name = "instance"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy_attachment" "attach" {
  name       = "attachment"
  roles      = [aws_iam_role.instance.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "profile" {
  name = "profile"
  role = aws_iam_role.instance.name
}