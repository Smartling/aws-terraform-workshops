# Specify missing or incomplete arguments according to documentation:
# Docs: https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html
resource "aws_autoscaling_group" "" {
  name =
  launch_configuration =
  load_balancers =

  availability_zones = [ "${var.availability_zone}" ]
  vpc_zone_identifier = [ "${var.subnet_id}" ]
  lifecycle { create_before_destroy = true }
  min_size = 1
  max_size = 1
}

resource "aws_launch_configuration" "" {
  security_groups = [ ]
  user_data = "${file("user-data.txt")}"
  image_id = "ami-cb2305a1"
  instance_type = "t2.micro"
  lifecycle { create_before_destroy = true }
}

