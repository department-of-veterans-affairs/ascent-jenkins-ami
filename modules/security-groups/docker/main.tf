#######################################################################################################################
#  AWS SECURITY GROUP FOR JENKINS SLAVE INSTANCES
#######################################################################################################################
resource "aws_security_group" "docker" {
   name			= "${var.name}"
   description		= "${var.description}"
   vpc_id		= "${var.vpc_id}"

   # ssh access
   ingress {
      from_port		= "${var.ssh_port}"
      to_port		= "${var.ssh_port}"
      protocol		= "tcp"
      cidr_blocks	= ["${var.allowed_cidr_blocks}"]
   }

   # unencrypted traffic from Jenkins
   ingress {
     from_port          = "${var.jenkins_unencrypted_port}"
     to_port            = "${var.jenkins_unencrypted_port}"
     protocol           = "tcp"
     security_groups	= ["${aws_security_group.jenkins.id}"]
   }

  # encrypted traffic from Jenkins
   ingress {
     from_port          = "${var.jenkins_encrypted_port}"
     to_port            = "${var.jenkins_encrypted_port}"
     protocol           = "tcp"
     security_groups	= ["${aws_security_group.jenkins.id}"]
   }

   egress {
     from_port          = 0
     to_port            = 0
     protocol           = "-1"
     cidr_blocks	= ["${var.allowed_cidr_blocks}"]
   }
}
