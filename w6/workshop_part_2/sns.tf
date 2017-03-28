/*

# Uncomment and add missing arguments here. Keep rest configuration as is.

resource "aws_sns_topic" "scale_notifications" {
  name =
}

resource "aws_autoscaling_notification" "ecs_asg_up_notifications" {
  group_names = [ "${aws_autoscaling_group.w6-asg.name}" ]
  notifications  = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE"
  ]
  topic_arn = "${aws_sns_topic.scale_notifications.arn}"
}

*/
