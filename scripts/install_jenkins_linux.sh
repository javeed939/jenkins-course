#!/bin/bash

# install docker

sudo yum update –y

sudo yum upgrade

sudo dnf install java-17-amazon-corretto -y

sudo yum install docker -y


sudo systemctl start docker


sudo systemctl enable docker

usermod -a -G docker $(whoami)

mkdir -p /var/jenkins_home

chown -R 1000:1000 /var/jenkins_home/

docker  run -p 8080:8080 -p 50000:50000 -v /var/jenkins_home:/var/jenkins_home -d --name jenkins jenkins/jenkins:lts

# show endpoint
echo 'Jenkins installed'
echo 'You should now be able to access jenkins at: http://'$(curl -4 -s ifconfig.co)':8080'
