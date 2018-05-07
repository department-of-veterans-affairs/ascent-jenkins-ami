#######################################################################################################################
#  Jenkins slave module
#######################################################################################################################

# ---------------------------------------------------------------------------------------------------------------------
# JENKINS SLAVE EC2 INSTANCE
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_instance" "jenkins_slave" {
  instance_type = "${var.instance_type}"

  # Use value of supplied variable, if specified, but if not,
  #     lookup the latest AMI we have for nomad-consul-amazon-linux-*
  ami = "${var.jenkins_slave_ami_id}"

  key_name = "${var.key_name}"

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = ["${module.security_group.security_group_id}"]

  subnet_id = "${var.instance_subnet_id}"
  user_data = "${data.template_file.user_data_slave.rendered}"

  tags {
    Name = "${var.instance_name}",
    SAN = "${var.san}"
    ProjectName = "${var.project_name}"
    VAECID = "${var.vaecid}"
    Environment = "${var.env}"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# JENKINS SLAVE SECURITY GROUP
# ---------------------------------------------------------------------------------------------------------------------
module "security_group" {
  source = "../security-groups/docker/"
  vpc_id = "${var.vpc_id}"
  jenkins_master_security_group_id = "${var.jenkins_master_security_group_id}"
}

# ---------------------------------------------------------------------------------------------------------------------
# JENKINS SLAVE USER DATA
# ---------------------------------------------------------------------------------------------------------------------
data "template_file" "user_data_slave" {
  template = "${file("${path.module}/user-data.sh")}"
  vars {
    VAULT_URL="${var.vault_url}",
    DOCKER_REPO_URL="${var.docker_repo_url}",
    DOCKER_DEPLOY_URL="${var.docker_deploy_url}"
  }
}
