output "private_ip" {
  value = "${aws_instance.jenkins_slave.private_ip}"
}

output "security_group_id" {
  value = "${aws_security_group.jenkins_slave.id}"
}

output "api_port" {
  value = "${var.api_port}"
}
