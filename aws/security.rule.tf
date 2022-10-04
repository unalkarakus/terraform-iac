resource "aws_security_group_rule" "ssh_ingress" {
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.trainingsg.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "tcp_ingress" {
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.trainingsg.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}