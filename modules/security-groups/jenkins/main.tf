#######################################################################################################################
#  AWS SECURITY GROUP FOR JENKINS MASTER INSTANCE
#######################################################################################################################
resource "aws_security_group" "jenkins" {
  name        = "${var.name}"
  description = "${var.description}"
  vpc_id      = "${var.vpc_id}"

  # HTTP access from anywhere
  ingress {
    from_port   = "${var.http_access_port}"
    to_port     = "${var.http_access_port}"
    protocol    = "tcp"
    cidr_blocks = ["${var.allowed_cidr_blocks}"]
  }

  # JNLP access from anywhere
  ingress {
    from_port   = "${var.jnlp_access_port}"
    to_port     = "${var.jnlp_access_port}"
    protocol    = "udp"
    cidr_blocks = ["${var.allowed_cidr_blocks}"]
  }
  ingress {
    from_port   = "${var.jnlp_access_port}"
    to_port     = "${var.jnlp_access_port}"
    protocol    = "tcp"
    cidr_blocks = ["${var.allowed_cidr_blocks}"]
  }

  # SSH access from anywhere
  ingress {
    from_port   = "${var.ssh_port}"
    to_port     = "${var.ssh_port}"
    protocol    = "tcp"
    cidr_blocks = ["${var.allowed_cidr_blocks}"]
  }

  # Monitoring Client
  ingress {
    from_port   = "${var.monitoring_client_port}"
    to_port     = "${var.monitoring_client_port}"
    protocol    = "tcp"
    cidr_blocks = ["${var.allowed_cidr_blocks}"]
  }

  ingress {
      from_port = "${var.icmp_upper_bound_port}"
      to_port = "${var.icmp_lower_bound_port}"
      protocol = "icmp"
      cidr_blocks = ["${var.allowed_cidr_blocks}"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.allowed_cidr_blocks}"]
  }
}
