# Add rule into security group that allows incoming connections from instances/ELBs
#   which reside in this security group.
#
# Docs: https://www.terraform.io/docs/providers/aws/r/security_group.html
resource "aws_security_group" "w3-security-group" {
  description = "W3 security group."

  ingress {
    # Add here rule that allows incoming connections to
    # application running under docker via 80 port

    from_port = 
    to_port = 
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

  # Access to instances via SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  # Access to Internet for instance
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  # Keep this argument as is:
  vpc_id = "${var.vpc_id}"
}
