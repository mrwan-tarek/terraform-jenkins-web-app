#!/bin/bash
touch f1
yum update -y
touch f2
yum install git -y
touch f3
yum install httpd -y
git clone --branch app --single-branch https://github.com/mrwan-tarek/terraform-jenkins-web-app.git
cp  /home/ec2-user/terraform-jenkins-web-app/index.php /var/www/html/
chmod -R 755 /var/www/html
systemctl start httpd