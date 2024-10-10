# ============ Ubuntu Security Group ============
resource "aws_security_group" "ubuntu_sg" {
  name        = "ubuntu_sg"
  description = "Allows ICMP (Echo), SSH, HTTP, and HTTPS traffic"
  vpc_id      = data.aws_vpc.default_vpc.id
}

resource "aws_security_group_rule" "ubuntu_sg_icmp_echo_ingress_rule" {
  type              = "ingress"
  description       = "Allows ingress ICMP (Echo) traffic on port 8"
  from_port         = 8
  to_port           = 0
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ubuntu_sg.id
}

resource "aws_security_group_rule" "ubuntu_sg_tcp_ssh_ingress_rule" {
  type              = "ingress"
  description       = "Allows ingress TCP (SSH) traffic on port 22"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ubuntu_sg.id
}

resource "aws_security_group_rule" "ubuntu_sg_tcp_http_ingress_rule" {
  type              = "ingress"
  description       = "Allows ingress TCP (HTTP) traffic on port 80"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ubuntu_sg.id
}

resource "aws_security_group_rule" "ubuntu_sg_tcp_https_ingress_rule" {
  type              = "ingress"
  description       = "Allows ingress TCP (HTTPS) traffic on port 443"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ubuntu_sg.id
}

resource "aws_security_group_rule" "ubuntu_sg_egress_rule" {
  type              = "egress"
  description       = "Allows all egress traffic"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ubuntu_sg.id
}