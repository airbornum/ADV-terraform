resource "aws_instance" "bionic_beaver" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
}
