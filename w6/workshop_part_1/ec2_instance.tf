# Keep this file as is.

resource "aws_instance" "w6-instance" {
  instance_type = "t2.nano"
  vpc_security_group_ids = [ "${aws_security_group.w6-sg.id}" ]
  associate_public_ip_address = true
  user_data = "${file("../user-data.txt")}"

  iam_instance_profile = "${aws_iam_instance_profile.w6-profile.name}"

  ami = "ami-cb2305a1"
  availability_zone = "${var.availability_zone_id}"
  subnet_id = "${var.availability_zone_id}"

  depends_on = ["aws_iam_instance_profile.w6-profile"]
}
