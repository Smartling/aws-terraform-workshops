# Add missing and/or incomplete arguments to ec2 instance resource below.
# This instance will run Jenkins server, consider this when configuring it.
resource "aws_instance" "jenkins_ec2_instance" {

  availability_zone = "${var.availability_zone_id}"
  vpc_security_group_ids = ["${aws_security_group.w4-jenkins.id}"]
  subnet_id = "${var.subnet_id}"

  tags {
    Name = "jenkins-w4"
  }

  user_data = "${template_file.user_data_template.rendered}"

  # Keep these arguments as is:
  ami = "ami-cb2305a1"
  instance_type = "t2.medium"
  associate_public_ip_address = false
  iam_instance_profile = "${aws_iam_instance_profile.w4-profile.name}"
  depends_on = ["aws_s3_bucket_object.jenkins_bootstrap_script"]
}

resource "template_file" "user_data_template" {
  template = "${file("files/user-data.txt.tmpl")}"

  vars {
    s3_bucket_name = "${aws_s3_bucket.bootstrap_scripts.bucket}"
  }
}
