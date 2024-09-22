# Define Variables for Instance Configuration
variable "region" {
  default = "ap-south-1"

}

variable "instance_count" {
  default = 2 # Update with desired number of instances
}

variable "instance_type" {
  default = "t2.micro" # Update with desired instance type
}

data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
# Reference Default VPC and Subnet

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "public" {
  filter {
    name   = "tag:Name"
    values = ["default-public-1"]
  }

}

# data "aws_subnet" "public" {
#   availability_zone = data.aws_vpc.default.availability_zones[0]
# }