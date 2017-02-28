# Add missing arguments here if necessary.
# Docs: https://www.terraform.io/docs/providers/aws/r/security_group.html
resource "aws_security_group" "w5" {
  description = "W5 security group."

  # This rule allows incoming connections via tcp/80
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

  vpc_id = "${var.vpc_id}"
}
