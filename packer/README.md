# ascent-jenkins-ami

# Configuration References
* [Configure Global Shared Library](https://www.diabol.se/blog/programmatically-configure-jenkins-pipeline-shared-groovy-libraries/)

# Post Terraform Configuration Instructions

## Email Notifications
You need to edit /etc/sysconfig/jenkins and restart Jenkins.
You need to have both
* JENKINS_JAVA_OPTIONS="-Djava.awt.headless=true -Dmail.smtp.starttls.enable=true"
* JENKINS_ARGS="-Dmail.smtp.starttls.enable=true"