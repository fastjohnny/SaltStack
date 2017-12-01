# user creation
users:
    supauser:
      fullname: Skolkovo System Admin
      shell: /bin/bash
      home: /home/supauser/
      linux_password: $1$FQETRyne$4xP5czYcnojN.pQR6Pn.I1
      enforce_password: True
      key_pub: True
      groups:
        - sudo
