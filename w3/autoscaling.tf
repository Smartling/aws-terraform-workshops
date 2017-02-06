# Specify missing or incomplete arguments according to documentation:
# Docs: https://www.terraform.io/docs/providers/aws/r/launch_configuration.html
resource "aws_launch_configuration" "" {
  security_groups =
  user_data = "${file("user-data.txt")}"
  instance_type =

  # Keep these arguments
  image_id = "ami-cb2305a1"
  lifecycle { create_before_destroy = true }
}

# Specify missing or incomplete arguments according to documentation:
# Docs: https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html
resource "aws_autoscaling" "" {
  name =
  min_size =
  max_size =
  launch_configuration =
  
  health_check_type = "EC2"
  # health_check_grace_period = 5

  # Attach ELB to ASG here:
  # Find whatever you need in terraform documentation

  # Keep these arguments
  availability_zones = [ "${var.availability_zone_id}" ]
  vpc_zone_identifier = [ "${var.subnet_id}" ]
  lifecycle { create_before_destroy = true }
}

/*
# Specify arguments according to documentation
# Docs: https://www.terraform.io/docs/providers/aws/r/autoscaling_notification.html
resource "" "autoscaling_notification" {
  group_names = [ ]
  topic_arn =
  notifications  = [ "autoscaling:EC2_INSTANCE_LAUNCH", "autoscaling:EC2_INSTANCE_TERMINATE" ]
}
*/
