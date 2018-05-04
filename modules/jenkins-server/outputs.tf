output "jenkins_master_ip" {
  value = "${aws_instance.jenkins_master.private_ip}"
}
