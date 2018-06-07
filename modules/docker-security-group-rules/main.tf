#######################################################################################################################
#  AWS SECURITY GROUP FOR DOCKER API ACCESS
#######################################################################################################################

resource "aws_security_group_rule" "allow_api_inbound_from_cidr_blocks" {
  count       = "${length(var.allowed_inbound_cidr_blocks) >= 1 ? 1 : 0}"
  type        = "ingress"
  from_port   = "${var.api_port}"
  to_port     = "${var.api_port}"
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_cidr_blocks}"]

  security_group_id = "${var.security_group_id}"
}

resource "aws_security_group_rule" "allow_api_inbound_from_security_group" {
  count       = "${length(var.allowed_inbound_security_groups) >= 1 ? 1 : 0}"
  type        = "ingress"
  from_port   = "${var.api_port}"
  to_port     = "${var.api_port}"
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_security_groups}"]

  security_group_id = "${var.security_group_id}"
}
