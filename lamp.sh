#!/bin/bash
#this lamp shall script




WHOAMI=`whoami`;
if [ $WHOAMI != "root" ]; then
  echo "You MUST be a root to run this script"
  exit 2
fi
echo -e " if u want lamp installation[y/n]:\c"

read y


if [  $y == y -o $y == Y ] ; then
yum -y install httpd
systemctl start httpd
systemctl enable httpd
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --reload
yum -y install mariadb-server
systemctl start mariadb
mysql_secure_installation -y 
yum -y install php
#rpm -iUvh http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
#yum -y install phpmyadmin

elif [ $y == n -o $y == N ] ; then
exit;
else
echo "plz enter y or n " ;
fi
