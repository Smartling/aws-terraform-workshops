# Specify missing or incomplete arguments according to documentation:
# Docs: https://www.terraform.io/docs/providers/aws/r/lambda_function.html
resource "aws_lambda_function" "scheduled_lambda_function" {
  function_name = "tf-w5"
  role = "${aws_iam_role.w5.arn}"
  timeout = 8

  # Keep these arguments as is:
  vpc_config = {
    subnet_ids = [ "${var.subnet_id}" ]
    security_group_ids = [ "${aws_security_group.w5.id}" ]
  }
  runtime = "python2.7"
  filename = "files/scheduled_lambda.zip"
  handler = "example.lambda_handler"
}

# Cloudwatch Events Schedule, it's required to trigger AWS Lambda periodically.
# Docs: https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_rule.html
resource "aws_cloudwatch_event_rule" "scheduled_lambda_schedule" {
  schedule_expression = "rate(5 minutes)"
  name =  "tf-w5"
  description = "CloudWatch Events Schedule to trigger Lambda function."
  is_enabled = true
}

# Below resources are required to trigger AWS Lambda by periodical Cloudwatch events (see above):
#
# aws_cloudwatch_event_target binds aws_cloudwatch_event_rule with AWS Lambda function,
# aws_lambda_permission adds permissions for CloudWatch to invoke Lambda function.

resource "aws_cloudwatch_event_target" "scheduled_lambda_event_target" {
  rule = "${aws_cloudwatch_event_rule.scheduled_lambda_schedule.name}"
  target_id = "InvokeLambda"
  arn = "${aws_lambda_function.scheduled_lambda_function.arn}"
}

resource "aws_lambda_permission" "scheduled_lambda_cloudwatch_permission" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.scheduled_lambda_function.arn}"
  principal = "events.amazonaws.com"
  source_arn = "${aws_cloudwatch_event_rule.scheduled_lambda_schedule.arn}"
}

