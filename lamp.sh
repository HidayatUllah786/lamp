#!/bin/bash

WHOAMI=`whoami`;



if [ $WHOAMI != "root" ]; then
  echo "You MUST be a root to run this script"
  exit 2
fi
echo -e " do u want lamp installation[y/n]:\c"

read y
if [  $y == y -o $y == Y ] ; then
  HTTPD=`rpm -qa httpd`
    if [ $HTTPD = "httpd-2.4.6-67.el7.centos.6.x86_64" ]; then
     	 echo "apache already installed"
         else
        	yum -y install httpd
        	systemctl start httpd
        	systemctl enable httpd
        	firewall-cmd --permanent --add-port=80/tcp
        	firewall-cmd --reload
    fi

 PHP=`rpm -qa php`
     if [ $PHP = "php-5.4.16-43.el7_4.1.x86_64" ];then
          echo "PHP already installed"
        else 
          yum -y install php
     fi

MARIADB=`rpm -qa mariadb`
     if [ $MARIADB = "mariadb-5.5.56-2.el7.x86_64" ]; then
          echo "mariadb already installed"
      else

        yum -y install mariadb-server
        systemctl start mariadb
        systemctl enable mariadb
        mysql -u root -e "SET PASSWORD FOR root@'localhost' = PASSWORD('admin');"
     fi

PMA=`rpm -qa phpMyAdmin`
     if [ $PMA = "phpMyAdmin-4.4.15.10-2.el7.noarch" ]; then

        echo "PhpMyadmin already installed"
     else
       yum -y install phpmyadmin
       cat phpmyadmin.conf > /etc/httpd/conf.d/phpMyAdmin.conf
       systemctl restart httpd
    fi

fi
