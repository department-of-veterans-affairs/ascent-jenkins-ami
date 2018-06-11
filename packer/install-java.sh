#! /bin/bash

JAVA_VERSION=1.8.0_171

# Install Java Runtime
curl -L -H "Cookie: oraclelicense=accept-securebackup-cookie" -o jdk$JAVA_VERSION.tar.gz "http://download.oracle.com/otn-pub/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/jdk-8u171-linux-x64.tar.gz"
tar -xzf jdk$JAVA_VERSION.tar.gz
rm jdk$JAVA_VERSION.tar.gz
sudo mkdir -p /usr/lib/jvm
sudo mv jdk$JAVA_VERSION /usr/lib/jvm/jdk$JAVA_VERSION
sudo chown -R root:root /usr/lib/jvm/jdk$JAVA_VERSION

sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk$JAVA_VERSION/bin/java 1200
