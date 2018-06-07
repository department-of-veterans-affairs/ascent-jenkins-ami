#######################################################################################################################
#  Jenkins slave module
#######################################################################################################################

# ---------------------------------------------------------------------------------------------------------------------
# JENKINS SLAVE EC2 INSTANCE
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_instance" "jenkins_slave" {
  instance_type = "${var.instance_type}"
  ami = "${var.ami_id}"
  key_name = "${var.key_name}"
  vpc_security_group_ids = ["${module.jenkins_security_group.jenkins_slave_security_group_id}"]
  subnet_id = "${var.subnet_id}"
  user_data = "${var.user_data}"

  tags = [
    {
      key = "Name"
      value = "${var.name}"
    },
    "${var.tags}",
  ]
}

# ---------------------------------------------------------------------------------------------------------------------
# JENKINS SLAVE SECURITY GROUP
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "jenkins_slave" {
  name        = "${var.name}-slave-sg"
  description = "Security group for ${var.name}"
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group_rule" "allow_ssh_inbound_from_cidr_blocks" {
  count       = "${length(var.allowed_inbound_cidr_blocks) >= 1 ? 1 : 0}"
  type        = "ingress"
  from_port   = "${var.ssh_port}"
  to_port     = "${var.ssh_port}"
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_cidr_blocks}"]

  security_group_id = "${aws_security_group.jenkins_slave.id}"
}

resource "aws_security_group_rule" "allow_ssh_inbound_from_security_group" {
  count       = "${length(var.allowed_inbound_security_groups) >= 1 ? 1 : 0}"
  type        = "ingress"
  from_port   = "${var.ssh_port}"
  to_port     = "${var.ssh_port}"
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_security_groups}"]

  security_group_id = "${aws_security_group.jenkins_slave.id}"
}

resource "aws_security_group_rule" "allow_all_outbound" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.jenkins_slave.id}"
}

module "docker_security_group_rules" {
  source = "../docker-security-group-rules"

  security_group_id = "${aws_security_group.jenkins_slave.id}"
  allowed_security_groups = "${var.allowed_security_groups}"
  jnlp_access_port = "${var.api_port}"
}