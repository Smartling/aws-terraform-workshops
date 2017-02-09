# Specify names for EC2 instance profile and IAM Role, the rest configuration
# can be kept as is.

resource "aws_iam_instance_profile" "w4-profile" {
  name =
  roles = [ "${aws_iam_role.w4-role.name}" ]
}

resource "aws_iam_role" "w4-role" {
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
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "s3-policy" {
  name = "s3-policy"
  role = "${aws_iam_role.w4-role.id}"
  policy = <<EOF
{
  "Statement": [{
    "Effect": "Allow",
    "Action": [
      "s3:*"
    ],
    "Resource": "*"
  }]
}
EOF
}
