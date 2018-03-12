#NETWORK CONFIGURATION
keepalived_vip: 10.254.64.69
master_ip: 10.254.64.70
slave1_ip: 10.254.64.71
slave2_ip: 10.254.64.72
netmask: 27

master_hostname: S05V023-RMQ
slave1_hostname: S05V024-RMQ
slave2_hostname: S05V025-RMQ

rabbit_users:
    user1:
      name: user
      password: R2f9ytfGYbTK
#    user2:
#      name: testuser
#      password: userTEST

vhosts:
  - name: 'yellow'
  - name: 'dev'
  - name: 'test'
  - name: 'release'

#You can leave this one unchanged
erlang_cookie: 'EXHKUOWIWEAZUOYUAGAS'
