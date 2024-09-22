# Create Security Group
resource "aws_security_group" "allow_http" {
  name        = "AllowHTTP"
  description = "Allows inbound traffic on port 8000"


  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow all traffic for now (adjust as needed)
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow all traffic for now (adjust as needed)
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create EC2 Instances (dynamic number)
resource "aws_instance" "ec2_instances" {
  count = var.instance_count # Define number of instances in a variable

  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = data.aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.allow_http.id]
  associate_public_ip_address = true
  iam_instance_profile        = "SSMReadRole"

  # Use user data script for post-provisioning tasks
  user_data = file("${path.module}/docs/userdata.sh")

  tags = {
    Name = format("MyInstance-%d", count.index)
  }
}