resource "aws_instance" "ubuntu" {
  ami                    = "ami-0084a47cc718c111a"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ubuntu_sg.id]

  user_data                   = file("ubuntu_user_data.sh")
  user_data_replace_on_change = true

  tags = {
    Name = "ubuntu"
  }
}