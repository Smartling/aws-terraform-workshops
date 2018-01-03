/*

# SNS Topic for Lamda to send alerts to
resource "aws_sns_topic" "notifications" {
  name = 
}

# AWS Lambda function
resource "aws_lambda_function" "ecs_failed_deploys_lambda" {
  function_name = 
  filename = "files/ecs_failed_deploys.zip"
  role = "${aws_iam_role.w7-role.arn}"
  runtime = "python2.7"
  timeout = "8"
  handler = "lambda_function.lambda_handler"
  source_code_hash = "${base64sha256(file("files/ecs_failed_deploys.zip"))}"
}

# Cloudwatch Events Schedule, it's required to trigger AWS Lambda periodically.
resource "aws_cloudwatch_event_rule" "ecs_failed_deploys_lambda_schedule" {
  name =
  description = "CloudWatch Events Schedule to trigger Lambda."
  schedule_expression = "rate(5 minutes)"
  is_enabled = true
}

resource "aws_cloudwatch_event_target" "ecs_failed_deploys_lambda_target" {
  rule = "${aws_cloudwatch_event_rule.ecs_failed_deploys_lambda_schedule.name}"
  target_id = "InvokeLambda"
  arn = "${aws_lambda_function.ecs_failed_deploys_lambda.arn}"
  input = "{\"ecs_service_name\":\"${aws_ecs_service.w7-elb-ecs-service.name}\", \"ecs_cluster_name\":\"${aws_ecs_cluster.w7-ecs-cluster.id}\", \"sns_topic_arn\":\"${aws_sns_topic.notifications.arn}\"}"
}

resource "aws_lambda_permission" "ecs_failed_deploys_lambda_cloudwatch_permission" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.ecs_failed_deploys_lambda.arn}"
  principal = "events.amazonaws.com"
  source_arn = "${aws_cloudwatch_event_rule.ecs_failed_deploys_lambda_schedule.arn}"
}

*/
