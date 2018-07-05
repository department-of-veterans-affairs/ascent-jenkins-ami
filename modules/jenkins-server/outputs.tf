output "jenkins_master_ip" {
  value = "${aws_instance.jenkins_master.private_ip}"
}


output "http_port" {
  value = "${module.jenkins_security_group.http_port}"
}

output "jenkins_master_security_group_id" {
  value = "${module.jenkins_master_security_group_id}"
}
