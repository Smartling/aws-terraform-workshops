# Add missing arguments according to terraform/aws documentation.
# Docs: https://www.terraform.io/docs/providers/aws/r/elb.html
resource "aws_elb" "" {
  name =
  security_groups = [ ]

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    target = "HTTP:80/"
    healthy_threshold = 3
    unhealthy_threshold = 3
    timeout = 2
    interval = 5
  }

  subnets = [ "${var.subnet_id}" ]
  internal = true
}
