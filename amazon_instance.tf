resource "aws_instance" "amazon" {
  ami                    = "ami-0592c673f0b1e7665"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.amazon_sg.id]

  tags = {
    Name = "amazon"
  }
}