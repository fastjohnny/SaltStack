#repos and pkgs
include:
  - repos.rabbitmq
rabbitmq-pkg:
  pkg.installed:
    - pkgs:
      - erlang: 20.2.2-1.el7.centos
      - rabbitmq-server: 3.7.2-1.el7
      - keepalived
      - unzip
    - require:
      - pkgrepo: mirror-rabbitmq-erlang
      - pkgrepo: mirror-rabbitmq
