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
HTTPD=`rpm -qa  httpd`
MARIADB=`rpm -qa mariadb`
PHP=`rpm -qa php`
PHPMYADMIN=`rpm -qa phpMyAdmin`

if [ ! $HTTPD -a ! $HTTPD -a ! $PHP -a ! $PHPMYADMIN ] ;then
#echo " lamp stack was installed"
#else
HTTPD=`rpm -qa  httpd`
if [  $HTTPD ] ; then
echo "httpd already installed"
else
yum -y install httpd
systemctl start httpd
systemctl enable httpd
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --reload
fi
MARIADB=`rpm -qa mariadb`
if [ $MARIADB ]; then
echo " mariadb already installed"
else
yum -y install mariadb-server
systemctl start mariadb
mysql_secure_installation -y 
fi
PHP=`rpm -qa php`
if [ $PHP ]; then
echo "php already installed"
else
yum -y install php
fi
PHPMYADMIN=`rpm -qa phpMyAdmin` 
if [ $PHPMYADMIN ]; then
echo "phpMyAdmin already installed"
else
rpm -iUvh http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y install phpmyadmin
cat phpmyadmin.conf > /etc/httpd/conf.d/phpMyAdmin.conf
systemctl restart httpd
fi
else
echo "lamp stack was installed"
fi
elif [ $y == n -o $y == N ] ; then
exit;
else
echo "plz enter y or n " ;
fi
