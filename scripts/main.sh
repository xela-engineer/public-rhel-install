#!/bin/bash
set -e

# Install oh-my-bash
if [ -d "$HOME/.oh-my-bash" ]; then
    echo "oh-my-bash is already installed."
else
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
    sed -i 's/OSH_THEME="font"/OSH_THEME="agnoster"/g' ~/.bashrc
fi

# Fix the locale issue
if ! grep -q "export LC_ALL=C.UTF-8" ~/.bashrc; then
    echo "Setting locale to C.UTF-8"
    echo "export LC_ALL=C.UTF-8" >> ~/.bashrc
fi
ansible --help > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Ansible installation failed. Please check the installation logs."
    exit 1
fi

echo "Installing Repo"

if [ ! -f ../inventory/repos/rhel8/rhel.repo ]; then
  echo "Error: ../inventory/repos/rhel8/rhel.repo does not exist."
  exit 1
fi
touch /etc/yum.repos.d/rhel.repo
cp ../inventory/repos/rhel8/rhel.repo /etc/yum.repos.d/rhel.repo

# Install jq
dnf install -y xorg-x11-xauth jq


echo "Installation completed"