#!/bin/bash
mkdir /home/ec2-user/file
touch /home/ec2-user/mmmmmm
sudo yum update -y
sudo yum install mysql -y
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo chkconfig docker on
sudo chmod 666 /var/run/docker.sock
docker pull dhruvin30/dhsoniweb:v1
docker run -d -p 80:80 dhruvin30/dhsoniweb:latest