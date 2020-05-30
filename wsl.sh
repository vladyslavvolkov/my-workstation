#!/usr/bin/env sh

distribution=${OS:-alpine}

echo "Upgrading system packages"
case $distribution in
alpine)
  apk upgrade
  apk add --no-cache --update ansible
  rm -rf /var/cache/apk/*
  find /usr/lib/python3/site-packages | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf
  ;;
ubuntu | debian)
  apt-get update --yes
  apt-get full-upgrade --yes
  apt-get install --yes \
    python3-setuptools \
    python3-distutils \
    python3-wheel \
    wget
  wget -O- https://bootstrap.pypa.io/get-pip.py | python3
  pip3 install --upgrade --prefer-binary ansible
  apt-get purge snapd pulseaudio-utils fonts-dejavu-core git python3-setuptools python3-distutils python3-wheel --yes
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

echo "Setting default values for WSL distribution"
config=$(cat <<EOF
[automount]
enabled = false
options = "metadata,umask=022,fmask=011"
mountFsTab = false
[interop]
enabled = false
appendWindowsPath = false
[user]
default = "root"
EOF
)
echo "$config" > /etc/wsl.conf

[ -d /etc/ansible ] || mkdir /etc/ansible
echo "Downloading Ansible roles"
wget -O- https://github.com/Hiberbee/ansible/archive/master.tar.gz | tar xvz -C /etc/ansible --strip=1
cd /etc/ansible || exit
ansible --version
