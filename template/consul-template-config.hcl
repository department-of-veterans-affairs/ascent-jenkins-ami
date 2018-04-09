# See https://github.com/hashicorp/consul-template for config documentation

vault {
  renew_token   = false
  unwrap_token = false

  retry {
    attempts = 10
  }

  ssl {
    enabled = true
    verify  = false
  }
}

template {
  source = "/home/ec2-user/template/create-user.groovy.tpl"
  destination = "/var/lib/jenkins/init.groovy.d/create-user.groovy"
  perms = 755
}

 
