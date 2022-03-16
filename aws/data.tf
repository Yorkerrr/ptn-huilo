data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_ami" "amazon_linux2" {
  most_recent = true
  owners      = ["137112412989"] #Amazon
  filter {
    name = "name"
    values = [
      "amzn2-ami-hvm-*-x86_64-ebs"
    ]
  }
  filter {
    name = "owner-alias"
    values = [
      "amazon",
    ]
  }
}