resource "aws_iam_instance_profile" "w7-profile" {
  name =
  roles = ["${aws_iam_role.w7-role.name}"]
}

resource "aws_iam_role" "w7-role" {
  name =
  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    },
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    },
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "ecs-policy" {
  name = "aws-limited-access"
  role = "${aws_iam_role.w7-role.id}"
  policy = <<EOF
{
  "Statement": [{
    "Effect": "Allow",
    "Action": [
      "sns:*"
    ],
    "Resource": "*"
  }]
}
EOF
}
