sudo -u root bash -c : && RUNAS_root="sudo -u root"
$RUNAS_root bash<<_
grep -q "127.0.0.1 $HOSTNAME" /etc/hosts && echo 'Localhost already exists in hosts file' || echo "127.0.0.1 $HOSTNAME" >> /etc/hosts
echo 'deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/archive/2017.7.2 xenial main' > /etc/apt/sources.list.d/salt.list
wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
apt update
apt -y install python-pyinotify salt-minion
sed -i 's/#master: salt/master: /g' /etc/salt/minion
sed -i 's/#hash_type: sha256/hash_type: sha256/g' /etc/salt/minion
sed -i 's/#file_recv_max_size: 100/file_recv_max_size: 10000/g' /etc/salt/minion
systemctl restart salt-minion
_
