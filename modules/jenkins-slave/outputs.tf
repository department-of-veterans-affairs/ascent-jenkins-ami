output "private_ip" {
  value = "${aws_instance.jenkins_master.private_ip}"
}

output "security_group_id" {
  value = "${aws_security_group.jenkins_master.id}"
}
