#!/usr/bin/env bash

apt-get update --yes
apt-get full-upgrade --yes
apt-get install --yes \
  python3-dev \
  unzip \
  apt-transport-https \
  git \
  ca-certificates \
  curl \
  software-properties-common \
  gnupg2
update-ca-certificates
curl https://bootstrap.pypa.io/get-pip.py | python3
pip3 install --upgrade ansible
cd /etc || exit
[ -d ansible ] || git clone https://github.com/Hiberbee/ansible.git
cd ansible || exit
git reset --hard HEAD
git pull origin master
ansible --version
apt-get autoremove --yes
apt-get autoclean --yes
