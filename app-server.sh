#!/bin/bash
yum update -y
yum install git -y
yum install php-mysqlnd -y
yum install httpd -y
git clone --branch app --single-branch https://github.com/mrwan-tarek/terraform-jenkins-web-app.git
cp /terraform-jenkins-web-app/search.php /ec2-user/terraform-jenkins-web-app/submit.php /var/www/html/
chmod -R 755 /var/www/html
systemctl start httpd