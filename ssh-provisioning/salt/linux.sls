# Before apply anything, you need to manually execute following:
#   Password auth does not work for salt-ssh, you need to add a key for a first launch

# mkdir .ssh; nano .ssh/authorized_keys
#
# ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9Q8hDXaxu5XFuBpq1awMT5uLTQnKVbDuVCpPlP5zJz+78C49kEbURoBDu0YtDOsIh/FDC2l02VbITTdjrWvRA/Yh+JfHbtqH4aDy02IF570Y5du5b7BdBaGr8LDE8hSl+mEwThI0YMXeyjee+dly/DGGqIx/IG1wodzPEJC6sJWf2VVL9LBxNFi5TKgWxqr4RfowOkswerO6ZfS7NjiXgkAmQhL+fqJ4q3hsS/yPi2oDTJ4XhhX4OgE4AFtcY637SyxZOnfIHKrKH4bIPeLn0KcC9DeSMjIVY9kzJCKDqflIJjj0JbQGg8AuEHZ/CNwiy27/q1UyLs7YvcPuEYNp/ ubuntu@akulshin-keycloak

#   $ sudo apt-get update
#   $ sudo apt-get upgrade
#   $ sudo test -e /usr/bin/python || (sudo apt -y update && sudo apt install -y python-minimal)
#   $ sudo visudo
#   Add "ubuntu ALL=(ALL) NOPASSWD: ALL" as a last line in the file
#
# bash command, compiled into one string
# $ sudo apt-get -y update; sudo apt-get -y upgrade; sudo test -e /usr/bin/python || (sudo apt -y update && sudo apt install -y python-minimal); sudo visudo

# command for PROD
# sudo apt-get -y update; sudo test -e /usr/bin/python || (sudo apt -y update && sudo apt install -y python-minimal); sudo visudo

# system:
#     network.system:
#       - enabled: True
#       - hostname: {{ grains.id }}

# salt-ssh --config-dir=/Users/nikolaj/Work/Skolkovo/vsk_gitlab/saltstack/config  -vvvv linux-package-update-1 -i state.highstate

# include:
  # - jre8
  # - iptables_ipv6
  # - iptables_ipv4


# ubuntu_set_hostname:
#      cmd.run:
#        - name: >
#           sudo hostnamectl set-hostname {{grains.id}}
#        - onlyif: bash -c "if [ $(lsb_release -i |grep Ubuntu |wc -l) -ne 1 ]; then exit 1; fi"

common_packages:
  pkg.installed:
    - pkgs:
      - sudo
      - nano
      - dbus
      - htop
      - cron
      - python-apt
      - fail2ban
      - ntp
      - tzdata
      - debconf-utils
      - debconf
      - unzip
      - curlftpfs

# administrator:
#   user.present:
#     - fullname: Virtual Skolkovo System Admin
#     - shell: /bin/bash
#     - home: /home/administrator/
#     - password: $1$PUCuvzJq$dYz4zG0dqDmKf8.K.
#     - groups:
#       - sudo


# ensureSSHkey:
#   ssh_auth.present:
#     - user: vsksuperadm
#     - source: salt://test_ssh_key.pub
#     - config: '/home/vsksuperadm/.ssh/authorized_keys'

# add_nopasswd:
#    cmd.run:
#     - name: >
#         bash -c 'test $(cat /etc/sudoers |grep vsksuperadm |wc -l) -eq 0 &&
#         echo "vsksuperadm  ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers ||
#         echo "already have string to sudoers"'

modify_ban2fail:
   cmd.run:
    - name: >
        sed -i 's/bantime  = 600/bantime  = 3600/g' /etc/fail2ban/jail.conf;
        sed -i 's/maxretry = 3/maxretry = 5/g' /etc/fail2ban/jail.conf;
        service fail2ban restart;
    - require:
       - pkg: common_packages


# python_locale:
#  file.append:
#    - name: /home/vsksuperadm/.profile
#    - text: export LC_ALL=en_US.UTF-8


set_timezone_and_locale:
   cmd.run:
    - name: >
        dpkg-reconfigure --frontend=noninteractive tzdata;
        echo "Europe/Moscow" > /etc/timezone;
        dpkg-reconfigure -f noninteractive tzdata;
        sed -i 's/# ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/g' /etc/locale.gen;
        sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen;
        echo 'LANG="en_US.UTF-8"'>/etc/default/locale ;
        dpkg-reconfigure --frontend=noninteractive locales ;
        update-locale LANG=en_US.UTF-8;
    - require:
       - pkg: common_packages

# net.ipv6.conf.lo.disable_ipv6:
#   sysctl.present:
#     - value: 1
#
# net.ipv6.conf.all.disable_ipv6:
#   sysctl.present:
#     - value: 1
#
# net.ipv6.conf.default.disable_ipv6:
#   sysctl.present:
#     - value: 1

master:
  user.absent:
    - purge: true
    - force: true


ubuntu:
  user.absent:
    - purge: true
    - force: true
