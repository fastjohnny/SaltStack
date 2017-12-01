base:
  'user-and-pkg':
    - create_users
    - linux
  '-ssh-proxy-101':
    - proxy_add_key
  'users':
    - create_users
  'vm10':
    - create_users
  'vm1':
    - create_users
    - linux
  'netams-101':
    - create_users
    - linux
  'rk-salt-ws-3':
    - create_push
  'runner-test-rk-2':
    - create_users
  'vm-salt':
    - linux
    - create_users
