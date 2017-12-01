sshd_config_file:
  file.managed:
    - name: /etc/ssh/sshd_config
    - source: salt://sshd_config
