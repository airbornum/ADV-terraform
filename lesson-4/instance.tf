resource "aws_instance" "webserver" {
  ami                    = var.AMIS[var.AWS_REGION]
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.webserver.id]
  user_data              = file("user_data.sh")

  tags = {
    Name    = "WebServer"
    Owner   = "Yevhen Khadzhamov"
    Project = "Terraform Lessons"
  }
}

resource "aws_security_group" "webserver" {
  name        = "WebServer Security Group"
  description = "webserver SecurityGroup"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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
