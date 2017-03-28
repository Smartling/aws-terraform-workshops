# Docs: https://www.terraform.io/docs/providers/aws/r/ecs_cluster.html
resource "aws_ecs_cluster" "w6-ecs-cluster" {
  name = "w6-cluster"
}

# Docs: https://www.terraform.io/docs/providers/aws/r/ecs_task_definition.html
resource "aws_ecs_task_definition" "w6-task-def" {
  family = "w6-task-def"
  container_definitions = "${file("files/containers.txt")}"
}

# Docs: https://www.terraform.io/docs/providers/aws/r/ecs_service.html
resource "aws_ecs_service" "w6-ecs-service" {
  name = "w6-service"

  cluster = "${aws_ecs_cluster.w6-ecs-cluster.id}"
  task_definition = "${aws_ecs_task_definition.w6-task-def.arn}"

  desired_count = 1
  iam_role = "${aws_iam_role.w6-role.arn}"

  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent = 200

  load_balancer {
    elb_name = "${aws_elb.w6-elb.id}"
    container_name = "webservice"
    container_port = 80
  }

  lifecycle {
    ignore_changes = [ "desired_count" ]
  }
}
