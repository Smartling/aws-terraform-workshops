#!/bin/bash

# install percona mysql client
yum install http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm -y
sed 's/^gpgcheck.*/gpgcheck=0/g' -i /etc/yum.repos.d/percona-release.repo
yum install Percona-Server-client-55 -y

# install oracle jdk 1.8
cd /usr/src
  yum install -y wget
  wget -c --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u73-b02/jdk-8u73-linux-x64.rpm"
  yum localinstall jdk-8u73-linux-x64.rpm -y
cd -

# install jenkins and its requirements
cat <<FILE > /etc/yum.repos.d/jenkins.repo
[jenkins]
name=Jenkins
baseurl=http://pkg.jenkins-ci.org/redhat
gpgcheck=0
FILE
yum install -y git docker telnet jenkins

# install maven
if [[ ! -d /opt/apache-maven-3.1.1 ]];then
  cd /usr/src
    wget http://mirror.olnevhost.net/pub/apache/maven/maven-3/3.1.1/binaries/apache-maven-3.1.1-bin.tar.gz
    tar -xvzf apache-maven-3.1.1-bin.tar.gz
    mv apache-maven-3.1.1 /opt/
  cd -
fi

# change Jenkins default user and port
sed "s/^JENKINS_USER=.*/JENKINS_USER=\"root\"/g" -i /etc/sysconfig/jenkins
sed "s/^JENKINS_PORT=.*/JENKINS_PORT=\"8000\"/g" -i /etc/sysconfig/jenkins
service docker restart
service jenkins restart

# install terraform only if it's not installed yet
if [[ ! -x /usr/local/sbin/terraform || ! -x /usr/local/sbin/terraform-provider-aws ]];then
  cd /usr/src
    wget -c https://releases.hashicorp.com/terraform/0.6.13/terraform_0.6.13_linux_amd64.zip
    yum install unzip -y
    unzip terraform_0.6.13_linux_amd64.zip
    mv terraform* /usr/local/sbin/
    chmod +x /usr/local/sbin/terraform*
  cd -
fi
