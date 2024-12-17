#! /bin/bash
sudo hostnamectl set-hostname build_server
sudo yum update -y

useradd devops
echo devops | passwd --stdin devops
echo 'devops ALL=(ALL) NOPASSWD: ALL' | tee -a /etc/sudoers

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl stop sshd
systemctl start sshd

yum install fontconfig java-17-amazon-corretto-devel git -y
