#######################################################################################################################
#  Jenkins master module
#######################################################################################################################

# ---------------------------------------------------------------------------------------------------------------------
# JENKINS MASTER EC2 INSTANCE
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_instance" "jenkins_master" {
  instance_type = "${var.instance_type}"
  ami           = "${var.ami_id}"

  key_name = "${var.ssh_key_name}"

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = ["${aws_security_group.jenkins_master.id}"]

  subnet_id = "${var.subnet_id}"
  user_data = "${var.user_data}"

  tags = "${merge(var.tags, map("Name", "${var.name}"))}"
}

# ---------------------------------------------------------------------------------------------------------------------
# JENKINS SECURITY GROUP
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "jenkins_master" {
  name        = "${var.name}-master-sg"
  description = "Security group for ${var.name}"
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group_rule" "allow_all_outbound" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.jenkins_master.id}"
}

module "security_group_rules" {
  source = "../jenkins-security-group-rules"

  security_group_id               = "${aws_security_group.jenkins_master.id}"
  allowed_inbound_cidr_blocks     = "${var.allowed_inbound_cidr_blocks}"
  allowed_inbound_security_groups = "${var.allowed_inbound_security_groups}"
  http_access_port                = "${var.http_access_port}"
  ssh_port                        = "${var.ssh_port}"
}

module "security_slave_group_rules" {
  source = "../jenkins-slave-security-group-rules"

  security_group_id               = "${aws_security_group.jenkins_master.id}"
  allowed_inbound_security_groups = "${var.jenkins_slave_security_groups}"
  jnlp_access_port                = "${var.jnlp_access_port}"
  ssh_port                        = "${var.ssh_port}"
}
