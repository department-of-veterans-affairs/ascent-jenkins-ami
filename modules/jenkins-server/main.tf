#######################################################################################################################
#  Jenkins master module
#######################################################################################################################


# ---------------------------------------------------------------------------------------------------------------------
# AWS AMI DATA
# ---------------------------------------------------------------------------------------------------------------------
data "aws_ami" "jenkins_master" {
  count       = "${length(var.ami_id) >= 1 ? 0 : 1}"
  most_recent = true

  filter {
    name   = "name"
    values = ["ascent-jenkins-master *"]
  }

  owners = ["272417811699"]
}

# ---------------------------------------------------------------------------------------------------------------------
# JENKINS MASTER SECURITY GROUP
# ---------------------------------------------------------------------------------------------------------------------
module "jenkins_security_group" {
  source = "../security-groups/jenkins/"
  vpc_id = "${var.vpc_id}"
}

# ---------------------------------------------------------------------------------------------------------------------
# JENKINS MASTER EC2 INSTANCE
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_instance" "jenkins_master" {
  instance_type = "${var.instance_type}"

  # Use value of supplied variable, if specified, but if not,
  #     lookup the latest AMI we have for 'ascent-jenkins-master *'
  ami = "${data.aws_ami.jenkins_master.id}"

  key_name = "${var.key_name}"

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = ["${module.jenkins_security_group.jenkins_master_security_group_id}"]

  subnet_id = "${var.instance_subnet_id}"

  tags {
    Name = "${var.instance_name}",
    SAN = "${var.san}"
    ProjectName = "${var.project_name}"
    VAECID = "${var.vaecid}"
    Environment = "${var.env}"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# NOMAD and DOCKER SERVER TO RUN JENKINS SLAVES
# ---------------------------------------------------------------------------------------------------------------------

module "jenkins_slave" {
  source = "../jenkins_slave/"
  jenkins_master_security_group_id = "${module.jenkins_security_group.jenkins_master_security_group_id}"
  key_name = "${var.key_name}"
  instance_subnet_id = "${var.instance_subnet_id}"
  env = "${var.env}"
  vpc_id = "${var.vpc_id}"
}
