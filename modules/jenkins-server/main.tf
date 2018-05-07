#######################################################################################################################
#  Jenkins master module
#######################################################################################################################

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
  ami = "${var.jenkins_ami_id}"

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
  jenkins_slave_ami_id = "${var.jenkins_slave_ami_id}"
}
