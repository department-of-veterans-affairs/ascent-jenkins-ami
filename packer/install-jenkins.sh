#!/bin/bash
CONSUL_TEMPLATE_CONFIG=/home/ec2-user/template/consul-template-config.hcl
VAULT_ADDR=$1
VAULT_TOKEN=$2

# Install the Jenkins RPM repo
sudo curl -L -o /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

# Install jenkins
sudo yum install -y jenkins
sudo chkconfig jenkins on

# Move create-user bootstrap script to init.groovy.d
sudo mkdir -p /var/lib/jenkins/init.groovy.d
sudo /usr/local/bin/consul-template -once -config="$CONSUL_TEMPLATE_CONFIG" -vault-addr="$VAULT_ADDR" -vault-token="$VAULT_TOKEN"
sudo chown -R jenkins:jenkins /var/lib/jenkins/init.groovy.d
sudo chmod -R 755 /var/lib/jenkins/init.groovy.d

sudo service jenkins start
