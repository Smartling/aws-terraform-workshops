/*

# Add missing arguments according to terraform/aws documentation.
# Docs: https://www.terraform.io/docs/providers/aws/r/elb.html
resource "aws_elb" "" {
  name =
  security_groups = [ ]
  connection_draining =

  listener {
    # Add configuration of ELB listener here
  }

  # Configure ELB health checks here
  health_check {
    target = "HTTP:80/"
    healthy_threshold =
    unhealthy_threshold =
    timeout = 2
    interval = 5
  }

  # Keep these arguments as is:
  subnets = [ "${var.subnet_id}" ]
  internal = true
}

*/
