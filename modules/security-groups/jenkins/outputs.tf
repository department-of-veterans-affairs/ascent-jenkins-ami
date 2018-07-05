output "jenkins_master_security_group_id" {
  value = "${aws_security_group.jenkins.id}"
}

output "http_port" {
  value = "${var.http_access_port}"
}
