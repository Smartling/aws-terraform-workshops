# 1. Create security group for Jenkins server.
# 2. Create inbound rule in security group to allow incoming connections via 8000 tcp port from 0.0.0.0/0 network.
# 3. Create outbound rule in security group to allow outgoing connections from instance via any ports/protocols.

resource "aws_security_group" "w4-jenkins" {
  name = "w4-jenkins"
  vpc_id = "${var.vpc_id}"

  # Egress access
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  # Ingress access
  ingress {
    from_port = 8000
    to_port = 8000
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  # Ingress access
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  # Ingress access within this security group
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    self = true
  }

  # keep these arguments as is
  description = "Jenkins security group (W4)."
}
