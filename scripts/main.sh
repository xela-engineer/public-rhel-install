#!/bin/bash
set -e

# Install oh-my-bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
sed -i 's/OSH_THEME="font"/OSH_THEME="agnoster"/g' ~/.bashrc

# Fix the locale issue
echo "export LC_ALL=C.UTF-8" >> ~/.bashrc
ansible --help > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Ansible installation failed. Please check the installation logs."
    exit 1
fi

# Install Repo
touch /etc/yum.repos.d/rhel.repo
cp ../inventory/repos/rhel8/rhel.repo /etc/yum.repos.d/rhel.repo

# Install jq
dnf install -y xorg-x11-xauth jq
