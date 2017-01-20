/*
# Uncomment and specify resource arguments below according to documentation and workshop guide:
# https://www.terraform.io/docs/providers/aws/r/cloudwatch_metric_alarm.html
resource "aws_cloudwatch_metric_alarm" "cpu_high_alarm" {
  alarm_name = 
  alarm_description = "This alarm triggers when CPU load in Autoscaling group is high."
 
  metric_name =
  namespace = "AWS/EC2"
  dimensions {
    # Put proper dimensions here
  }
  statistic = "Average"

  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "1"
  
  period =
  threshold =
  
  # Use autoscaling policy ARN as an alarm action here
  # Reference: http://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html
  alarm_actions = [ ]
}
*/
