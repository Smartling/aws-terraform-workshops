resource "aws_security_group" "w1_security_group" {
  name = "johndoe-sg"

  description = "Test security group."

  # This is fake VPC ID, you should put real one to make this configuration working
  vpc_id = "vpc-11111111"
}

resource "aws_security_group_rule" "ssh_ingress_access" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ] 
  security_group_id = "${aws_security_group.w1_security_group.id}"
}

resource "aws_security_group_rule" "egress_access" {
  type = "egress"
  from_port = 0
  to_port = 65535
  protocol = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = "${aws_security_group.w1_security_group.id}"
}

resource "aws_instance" "w1_instance" {
  instance_type = "t2.nano"
  vpc_security_group_ids = [ "${aws_security_group.w1_security_group.id}" ]
  associate_public_ip_address = true
  user_data = "${file("../../shared/user-data.txt")}"
  tags {
    Name = "w1-myinstance"
  }
  
  ami = "ami-cb2305a1"
  availability_zone = "us-east-1c"

  # This is fake VPC subnet ID, please put real one to make this config working
  subnet_id = "subnet-1111111"
}
