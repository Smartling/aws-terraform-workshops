resource "aws_autoscaling_group" "w7-asg" {
  name = "w7-autoscale-group"
  launch_configuration = "${aws_launch_configuration.w7-lc.name}"

  availability_zones = [ "${var.availability_zone_id}" ]
  vpc_zone_identifier = [ "${var.subnet_id}" ]
  lifecycle { create_before_destroy = true }
  min_size = 2
  max_size = 2
}

resource "aws_launch_configuration" "w7-lc" {
  name_prefix = "w7-lc-"
  iam_instance_profile = "${aws_iam_instance_profile.w7-profile.id}"
  security_groups = [ "${aws_security_group.w7-sg.id}" ]

  user_data = <<EOF
${file("files/user-data.txt")}

echo ECS_CLUSTER=${aws_ecs_cluster.w7-ecs-cluster.name} > /etc/ecs/ecs.config
EOF

  depends_on = ["aws_iam_instance_profile.w7-profile"]

  image_id = "ami-cb2305a1"
  instance_type = "t2.micro"
  lifecycle { create_before_destroy = true }
}
