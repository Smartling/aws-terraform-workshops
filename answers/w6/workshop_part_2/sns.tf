resource "aws_sns_topic" "scale_notifications" {
  name = "w6-notifs"
}

resource "aws_autoscaling_notification" "ecs_asg_up_notifications" {
  group_names = [ "${aws_autoscaling_group.w6-asg.name}" ]
  notifications  = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE"
  ]
  topic_arn = "${aws_sns_topic.scale_notifications.arn}"
}
