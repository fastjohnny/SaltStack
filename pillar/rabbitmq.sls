#NETWORK CONFIGURATION
keepalived_vip: xx.xxx.xx.xx
master_ip: xx.xxx.xx.xx
slave1_ip: xx.xxx.xx.xx
slave2_ip: xx.xxx.xx.xx
netmask: 24

master_hostname: host1
slave1_hostname: host2
slave2_hostname: host3

rabbit_users:
    user1:
      name: user
      password: pass
#    user2:
#      name: testuser
#      password: userTEST

vhosts:
  - name: 'yellow'
  - name: 'dev'
  - name: 'test'
  - name: 'release'

#You can leave this one unchanged
erlang_cookie: 'EXHKUOWIWEJKFJDNERO'
