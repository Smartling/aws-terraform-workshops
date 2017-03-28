resource "aws_autoscaling_group" "w6-asg" {
  name = "w6-autoscale-group"
  launch_configuration = "${aws_launch_configuration.w6-lc.name}"
  load_balancers = [ "${aws_elb.w6-elb.name}" ]

  availability_zones = [ "${var.availability_zone_id}" ]
  vpc_zone_identifier = [ "${var.subnet_id}" ]
  lifecycle { create_before_destroy = true }
  min_size = 1
  max_size = 1
}

resource "aws_launch_configuration" "w6-lc" {
  name_prefix = "w6-lc"
  iam_instance_profile = "${aws_iam_instance_profile.w6-instance-profile.id}"
  security_groups = [ "${aws_security_group.w6-sg.id}" ]

  user_data = <<EOF
${file("../user-data.txt")}

echo ECS_CLUSTER=${aws_ecs_cluster.w6-ecs-cluster.name} > /etc/ecs/ecs.config
EOF

  depends_on = ["aws_iam_instance_profile.w6-instance-profile"]

  image_id = "ami-cb2305a1"
  instance_type = "t2.micro"
  lifecycle { create_before_destroy = true }
}
