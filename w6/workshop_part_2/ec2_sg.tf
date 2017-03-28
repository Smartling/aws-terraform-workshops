/*

# Uncomment and add missing arguments here (if necessary). Keep rest configuration as is.

resource "aws_security_group" "w6-sg" {
  description = "W6 security group for ELB and EC2 instances."

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  # This rule allows communication within security group via any protocol
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    self = true
  }

  # Access to Internet for instance
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  vpc_id = "${var.vpc_id}"
}

*/
