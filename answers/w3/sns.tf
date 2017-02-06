# Specify name of SNS topic
# Docs: https://www.terraform.io/docs/providers/aws/r/sns_topic.html
resource "aws_sns_topic" "w3-sns" {
  name = "w3-sns"
}
