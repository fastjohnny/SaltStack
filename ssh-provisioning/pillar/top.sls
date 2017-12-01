base:
  'user-and-pkg':
    - common_users
  'users':
    - users
  '-ssh-proxy-101':
    - users
    - users_vm10
    - users_vm1
    - users_skl-netams-101
    - supauser
  'vm10':
    - users_vm10
  'vm1':
    - users_vm1
  '-netams-101':
    - users_skl-netams-101
  'rk-salt-ws-3':
    - users_vm10
    - users_vm1
  'runner-test-rk-2':
    - users_vm10
    - users_vm1
  'vm-salt':
    - supauser
