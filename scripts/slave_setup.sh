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

yum groupinstall "Development Tools" -y

su - devops -c "curl https://pyenv.run | bash"

cat << 'EOF' >> /home/devops/.bashrc
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
EOF

su - devops -c "source /home/devops/.bashrc"

su - devops -c "pyenv install pypy3.8-7.3.11"