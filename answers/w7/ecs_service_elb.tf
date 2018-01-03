# Docs: https://www.terraform.io/docs/providers/aws/r/ecs_task_definition.html
resource "aws_ecs_task_definition" "w7-elb-task-def" {
  family = "w7-taskdef2"
  container_definitions = "${file("files/w7-step3-containers.txt")}"
}

# Docs: https://www.terraform.io/docs/providers/aws/r/ecs_service.html
resource "aws_ecs_service" "w7-elb-ecs-service" {
  name = "w7-service2"

  cluster = "${aws_ecs_cluster.w7-ecs-cluster.id}"
  task_definition = "${aws_ecs_task_definition.w7-elb-task-def.arn}"

  desired_count = 2

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent = 200

  iam_role = "${aws_iam_role.w7-role.arn}"

  load_balancer {
    elb_name = "${aws_elb.w7-elb.id}"
    container_name = "webservice"
    container_port = 80
  }
}

resource "aws_elb" "w7-elb" {
  name = "w7-elb"
  security_groups = [ "${aws_security_group.w7-sg.id}" ]

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
