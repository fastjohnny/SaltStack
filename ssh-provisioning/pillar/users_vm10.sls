# user creation
users:
    vsktest:
      fullname: Skolkovo System Admin
      shell: /bin/bash
      home: /home/vsktest/
      linux_password: $1$FQETRyne$4xP5czYcnojN.pQR6Pn.I1
      enforce_password: True
      key_pub: True
      groups:
        - sudo
minionid: rk-salt-ws-3
