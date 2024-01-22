#!/bin/bash

# install dependencies
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

# get gpg key
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

# add docker repo
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# update repository
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo systemctl enable docker

# jenkins setup
sudo mkdir -p /var/jenkins_home/.ssh
sudo cp /root/.ssh/authorized_keys /var/jenkins_home/.ssh/authorized_keys
sudo chmod 700 /var/jenkins_home/.ssh
sudo chmod 600 /var/jenkins_home/.ssh/authorized_keys
sudo chown -R 1000:1000 /var/jenkins_home
docker run -p 2222:22 -v /var/jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock --restart always -d javeed939/jenkins-slave
