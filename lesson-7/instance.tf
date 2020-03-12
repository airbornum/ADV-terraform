resource "aws_eip" "my_static_ip" {
  instance = aws_instance.webserver.id
  tags = {
    Name  = "Web Server IP"
    Owner = "Yevhen Khadzhamov"
  }
}

resource "aws_instance" "webserver" {
  ami                    = var.AMIS[var.AWS_REGION]
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.webserver.id]
  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Yevhen",
    l_name = "Khadzhamov",
    names  = ["Vasya", "Kolya", "Petya", "John", "Donald", "Kostya"]
  })

  tags = {
    Name    = "WebServer"
    Owner   = "Yevhen Khadzhamov"
    Project = "Terraform Lessons"
  }

  lifecycle {
    create_before_destroy = true
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
