#!/bin/bash

# Install oh-my-bash
if [ -d "$HOME/.oh-my-bash" ]; then
    echo "oh-my-bash is already installed."
else
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
    sed -i 's/OSH_THEME="font"/OSH_THEME="agnoster"/g' ~/.bashrc
fi

echo "Installing Repo"

if [ ! -f ./public-rhel-install/inventory/repos/rhel8/rhel.repo ]; then
  echo "Error: ./public-rhel-install/inventory/repos/rhel8/rhel.repo does not exist."
  exit 1
fi
touch /etc/yum.repos.d/rhel.repo
cp ./public-rhel-install/inventory/repos/rhel8/rhel.repo /etc/yum.repos.d/rhel.repo

# Install jq
dnf install -y xorg-x11-xauth jq glibc-langpack-en


echo "Installation completed"

# Check the locale issue
ansible --help > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Ansible installation failed. Please check the installation logs."
    exit 1
fi

# Other init steps
touch /root/.Xauthority