#! /bin/bash
hostnamectl set-hostname master_node
yum update -y

useradd devops
echo devops | passwd --stdin devops
echo 'devops ALL=(ALL) NOPASSWD: ALL' | tee -a /etc/sudoers
# echo 'jenkins ALL=(ALL) NOPASSWD: ALL' | tee -a /etc/sudoers
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl stop sshd
systemctl start sshd

yes '' | su - devops -c 'ssh-keygen -t RSA -f /home/devops/.ssh/id_rsa'

wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
yum upgrade -y
# Add required dependencies for the jenkins package
yum install fontconfig java-17-amazon-corretto-devel git -y
yum install jenkins -y
systemctl daemon-reload

systemctl enable jenkins
systemctl start jenkins
systemctl status jenkins
