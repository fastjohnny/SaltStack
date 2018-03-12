#Copying keepalived conf and track_script
keepalived_conf:
  file.managed:
    - name: /etc/keepalived/keepalived.conf
    - source: salt://rabbitmq/keepalived.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: rabbitmq-pkg
track_script:
  file.managed:
    - name: /etc/keepalived/chk_rabbit.py
    - source: salt://rabbitmq/chk_rabbit.py
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: rabbitmq-pkg
#Enabling master/backup states in keepalived with correct VIP
keepalived_conf_patch:
  cmd.run:
    - name: |
        if [[ $HOSTNAME == "{{ pillar['master_hostname'] }}" ]]
        then sed -i "s/BACKUP/MASTER/g" /etc/keepalived/keepalived.conf
        fi
        sed -i "s/keepalived_VIP/{{ pillar['keepalived_vip'] }}/g" /etc/keepalived/keepalived.conf
        sed -i "s/USER_RABBIT/{{ salt['pillar.get']('rabbit_users:user1:name') }}/g" /etc/keepalived/keepalived.conf
        sed -i "s/PASSWORD_RABBIT/{{ salt['pillar.get']('rabbit_users:user1:password') }}/g" /etc/keepalived/keepalived.conf
    - require:
      - file: keepalived_conf
keepalived-svc:
  service.running:
    - name: keepalived
    - enable: True
    - require:
      - pkg: rabbitmq-pkg
    - watch:
      - cmd: keepalived_conf_patch
