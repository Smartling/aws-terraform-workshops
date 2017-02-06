# Specify missing or incomplete arguments according to documentation:
# Docs: https://www.terraform.io/docs/providers/aws/r/launch_configuration.html
resource "aws_launch_configuration" "w3" {
  security_groups = [ "${aws_security_group.w3-security-group.id}" ]
  user_data = "${file("user-data.txt")}"
  instance_type = "t2.nano"

  # Keep these arguments
  image_id = "ami-cb2305a1"
  lifecycle { create_before_destroy = true }
}

# Specify missing or incomplete arguments according to documentation:
# Docs: https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html
resource "aws_autoscaling_group" "w3" {
  name = "w3-asg"
  min_size = 2
  max_size = 2
  launch_configuration = "${aws_launch_configuration.w3.name}"
  
  health_check_type = "ELB"
  health_check_grace_period = 300

  load_balancers = [ "${aws_elb.w3.name}" ]

  # Keep these arguments
  availability_zones = [ "${var.availability_zone_id}" ]
  vpc_zone_identifier = [ "${var.subnet_id}" ]
  lifecycle { create_before_destroy = true }
}

# Specify arguments according to documentation
# Docs: https://www.terraform.io/docs/providers/aws/r/autoscaling_notification.html
resource "aws_autoscaling_notification" "autoscaling_notification" {
  group_names = [ "${aws_autoscaling_group.w3.name}" ]
  topic_arn = "${aws_sns_topic.w3-sns.arn}"
  notifications  = [ "autoscaling:EC2_INSTANCE_LAUNCH", "autoscaling:EC2_INSTANCE_TERMINATE" ]
}
