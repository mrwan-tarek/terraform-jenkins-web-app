#!/bin/bash
yum update -y
yum install git -y
yum install httpd -y
git clone --branch app --single-branch https://github.com/mrwan-tarek/terraform-jenkins-web-app.git
cp  /terraform-jenkins-web-app/index.php /usr/share/httpd/noindex/index.html
chmod -R 755 /usr/share/httpd/noindex/
systemctl start httpd