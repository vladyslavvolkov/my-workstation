#!/usr/bin/env sh

distribution=${OS:-alpine}
hostUser=${HOST_USER}
ansibleDirectory=/etc/ansible

echo "Upgrading system packages"
case $distribution in
alpine)
  apk add --no-cache --update ansible
  rm -rf /var/cache/apk/*
  find /usr/lib/python3.8/site-packages | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf
  ;;
centos | fedora)
  yum update -y
  yum install -y ansible
  find /usr/lib/python3/site-packages | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf
  ;;
ubuntu | debian)
  apt-get update
  apt-get install --yes python3-setuptools python3-distutils python3-wheel wget
  wget -O- https://bootstrap.pypa.io/get-pip.py | python3
  pip3 install --upgrade --prefer-binary ansible
  apt-get purge snapd pulseaudio-utils fonts-dejavu-core git python3-setuptools python3-wheel --yes
  apt-get autoremove --yes
  apt-get autoclean --yes
  apt-get clean
  py3clean /usr
  rm -rf ~/.cache/pip/* /var/cache/apt/*
  ;;
*)
  echo "No actions provided for $distribution"
  ;;
esac

echo "Linking ssh keys"
[ ! -d "/mnt/c/Users/$hostUser/.ssh" ] || cp -rf "/mnt/c/Users/$hostUser/.ssh" "$HOME/.ssh"

[ -d $ansibleDirectory ] || mkdir $ansibleDirectory
echo "Downloading Ansible roles"
wget -O- https://github.com/Hiberbee/ansible/archive/master.tar.gz | tar xvz -C /etc/ansible --strip=1
cd $ansibleDirectory || exit

if [ -f "$ansibleDirectory/requirements.yml" ]; then
  echo "Installing required roles"
  ansible-galaxy install -r requirements.yml
fi

echo "Running Ansible playbook"
ansible-playbook playbook.yml
