#!/bin/bash
# INSTALLING DOCKER, JAVA and JENKINS ON RockyLinux
# 1. Install Docker
# Install yum-utils and Update
sudo yum install -y yum-utils
sudo yum update -y 

# Add docker repository
# add docker repo
sudo yum config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo

# List docker modules and install
sudo yum list docker-ce
sudo yum install docker-ce --nobest -y
sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo systemctl status docker.service
sudo docker --version

# verify that docker is running 
sudo docker run hello-world

# 2. Install Jenkins
# 2.1 Method 1
sudo yum install epel-release java-11-openjdk-devel
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade
# 2.2 Method 2 
sudo docker search jenkins
sudo docker pull jenkins/jenkins:lts
sudo docker volume create voljenkins
# run the container by attaching the volume and the targeted port(localhost)
docker run -d \
    -p 127.0.0.1:8080 \
    -v voljenkins:/var/jenkins_home \
    --name jenkins \
    jenkins/jenkins:lts

# verify that jenkins is running 
sudo docker ps -a

# verify on the webbrowser
http://localhost:8080

# setup jenkins
sudo docker exec <CONTAINER ID or NAME> \
sh -c "cat /var/jenkins_home/secrets/initialAdminPassword"


