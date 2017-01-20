# Keep this file as is
resource "aws_security_group" "w2_security_group" {
  description = "W2 security group."

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${var.vpc_id}"
}
