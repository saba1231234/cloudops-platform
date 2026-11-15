resource "aws_security_group" "web_firewall" {
  name        = "cloudops-server-firewall"
  description = "Firewall for CloudOps Platform EC2 server"
  vpc_id      = "vpc-0357e26425d327b2a"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.ssh_allowed_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "cloudops-server-firewall"
    Environment = "Learning"
    Project     = "CloudOps Platform"
  }
}

resource "aws_instance" "cloudops_server" {
  ami           = "ami-0a998864ea09aafaf"
  instance_type = "t3.small"

  subnet_id = "subnet-094c8784d770f5f5e"
  vpc_security_group_ids = [
    aws_security_group.web_firewall.id
  ]

  key_name             = "cloudops-key"
  iam_instance_profile = "CloudOpsEC2SSMRole"

  associate_public_ip_address = true
  ebs_optimized               = true
  monitoring                  = false

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
    instance_metadata_tags      = "disabled"
  }

  root_block_device {
    volume_size           = 8
    volume_type           = "gp3"
    encrypted             = false
    delete_on_termination = true
  }

  tags = {
    Name = "CloudOps-Platform-Server"
  }
}