resource "aws_security_group" "amazon_sg" {
  name        = "amazon_sg"
  description = "Allows ICMP (Echo), SSH, HTTP, and HTTPS traffic within the private network"
  vpc_id      = data.aws_vpc.default_vpc.id
}

resource "aws_security_group_rule" "amazon_sg_icmp_echo_ingress_rule" {
  type              = "ingress"
  description       = "Allows ingress ICMP (Echo) traffic within the private network on port 8"
  from_port         = 8
  to_port           = 0
  protocol          = "icmp"
  cidr_blocks       = [data.aws_vpc.default_vpc.cidr_block]
  security_group_id = aws_security_group.amazon_sg.id
}

resource "aws_security_group_rule" "amazon_sg_tcp_ssh_ingress_rule" {
  type              = "ingress"
  description       = "Allows ingress TCP (SSH) traffic within the private network on port 22"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [data.aws_vpc.default_vpc.cidr_block]
  security_group_id = aws_security_group.amazon_sg.id
}

resource "aws_security_group_rule" "amazon_sg_tcp_http_ingress_rule" {
  type              = "ingress"
  description       = "Allows ingress TCP (HTTP) traffic within the private network on port 80"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = [data.aws_vpc.default_vpc.cidr_block]
  security_group_id = aws_security_group.amazon_sg.id
}

resource "aws_security_group_rule" "amazon_sg_tcp_https_ingress_rule" {
  type              = "ingress"
  description       = "Allows ingress TCP (HTTPS) traffic within the private network on port 443"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [data.aws_vpc.default_vpc.cidr_block]
  security_group_id = aws_security_group.amazon_sg.id
}

resource "aws_security_group_rule" "amazon_sg_egress_rule" {
  type              = "egress"
  description       = "Allows all egress traffic within the private network"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [data.aws_vpc.default_vpc.cidr_block]
  security_group_id = aws_security_group.amazon_sg.id
}
