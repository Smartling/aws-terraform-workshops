resource "aws_elb" "w6-elb" {
  name = "w6-elb"
  security_groups = [ "${aws_security_group.w6-sg.id}" ]

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
  internal = false
}
