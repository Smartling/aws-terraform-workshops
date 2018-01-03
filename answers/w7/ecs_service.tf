# Docs: https://www.terraform.io/docs/providers/aws/r/ecs_task_definition.html
resource "aws_ecs_task_definition" "w7-task-def" {
  family = "w7-taskdef"
  container_definitions = "${file("files/w7-step2-containers.txt")}"
}

# Docs: https://www.terraform.io/docs/providers/aws/r/ecs_service.html
resource "aws_ecs_service" "w7-ecs-service" {
  name = "w7-service"

  cluster = "${aws_ecs_cluster.w7-ecs-cluster.id}"
  task_definition = "${aws_ecs_task_definition.w7-task-def.arn}"
  deployment_minimum_healthy_percent = 0

  desired_count = 1
}
