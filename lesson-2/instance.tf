resource "aws_instance" "bionic_beaver" {
  # count = 3 # Add 3 servers
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
}
