# Specify missing arguments according to documentation:
# https://www.terraform.io/docs/providers/aws/r/launch_configuration.html
resource "aws_launch_configuration" "" {
  security_groups =
  user_data = "${file("../shared/user-data.txt")}"

  # Keep below arguments 
  lifecycle { create_before_destroy = true }
  instance_type = "t2.micro"
  image_id = "ami-cb2305a1"
}

# Specify missing arguments according to documentation:
# https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html
resource "aws_autoscaling_group" "" {
  name = 
  min_size = 
  max_size = 
  launch_configuration =
  default_cooldown =

  # Keep below arguments
  availability_zones = [ "${var.availability_zone_id}" ]
  vpc_zone_identifier = [ "${var.subnet_id}" ]

  tag {
    key = "Name"
    value = "soa-workshop2"
    propagate_at_launch = true
  }

  lifecycle { create_before_destroy = true }
}

/*
# Uncomment and specify arguments according to documentation and workshop guide:
# https://www.terraform.io/docs/providers/aws/r/autoscaling_policy.html
resource "aws_autoscaling_policy" "autoscale_group_policy_up_x1" {
  name = "autoscale_group_policy_up_x1"
  scaling_adjustment =
  adjustment_type = "ChangeInCapacity"
  cooldown =
  autoscaling_group_name = "${aws_autoscaling_group.test_autoscaling_group.name}"
}
*/
