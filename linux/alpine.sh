#!/usr/bin/env ash


apk add --no-cache --update ansible
[ -d /etc/ansible ] || mkdir /etc/ansible
wget -qO- https://github.com/Hiberbee/ansible/archive/master.tar.gz | tar xvz -C /etc/ansible --strip=1
cd /etc/ansible || exit
ansible --version
