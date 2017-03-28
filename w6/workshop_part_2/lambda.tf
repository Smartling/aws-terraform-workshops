/*

# Uncomment and add missing arguments here. Keep rest configuration as is.

resource "aws_lambda_function" "ecs_autoscale_lambda" {
  function_name = 

  filename = "files/ecs_autoscale_lambda.zip"
  role = "${aws_iam_role.w6-role.arn}"
  runtime = "nodejs4.3"
  timeout = "8"
  handler = "lambda_ecs_autoscale.handler"

  environment {
    variables = {
      asg_name = "${aws_autoscaling_group.w6-asg.name}"
      ecs_cluster_name = "${aws_ecs_cluster.w6-ecs-cluster.name}"
      ecs_service_name = "${aws_ecs_service.w6-ecs-service.name}"
    }
  }
}

# IAM permission that is required to invoke AWS Lambda function from SNS
resource "aws_lambda_permission" "ecs_autoscale_lambda_sns_permission" {
  statement_id = "AllowExecutionFromSNS"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.ecs_autoscale_lambda.arn}"
  principal = "sns.amazonaws.com"
  source_arn = "${aws_sns_topic.scale_notifications.arn}"
}

# AWS Lambda is subsribed to SNS topic so events that come to it will be processed by Lambda.
resource "aws_sns_topic_subscription" "scale_sns_events" {
  topic_arn = "${aws_sns_topic.scale_notifications.arn}"
  protocol = "lambda"
  endpoint  = "${aws_lambda_function.ecs_autoscale_lambda.arn}"
}

*/
