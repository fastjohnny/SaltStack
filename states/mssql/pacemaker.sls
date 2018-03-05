#Corosync / Pacemaker configure and start
coros_conf:
  file.managed:
    - name: /etc/corosync/corosync.conf
    - source: salt://mssql/corosync.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: mssql-server-2017-pkg

hacluster:
  user.present:
    - fullname: hacluster
    - enforce_password: True
    - password: $1$VeYRaVZS$ucpwd97ovA/xtllAOdjwr. #pass HA1qaz@WSX
    - require:
        - pkg: mssql-server-2017-pkg

master_ip_replace:
  file.replace:
    - name: /etc/corosync/corosync.conf
    - repl: '{{ pillar['master_ip'] }}'
    - pattern: MASTER_IP
    - require:
      - file: coros_conf

slave_ip_replace:
  file.replace:
    - name: /etc/corosync/corosync.conf
    - repl: '{{ pillar['slave_ip'] }}'
    - pattern: SLAVE_IP
    - require:
      - file: coros_conf

current_ip_replace:
  file.replace:
    - name: /etc/corosync/corosync.conf
    - repl: '{{ salt['network.interfaces']()['eth0']['inet'][0]['address'] }}'
    - pattern: CURRENT_IP
    - require:
      - file: coros_conf

corosync-svc:
  service.running:
    - name: corosync
    - enable: True
    - require:
      - file: master_ip_replace
      - file: slave_ip_replace
      - file: current_ip_replace
    - watch:
      - file: coros_conf

pacemaker-svc:
  service.running:
    - name: pacemaker
    - enable: True
    - require:
      - service: corosync-svc
    - watch:
      - file: coros_conf

cib_conf:
  file.managed:
    - name: /root/cib.xml
    - source: salt://mssql/cib.xml
    - user: root
    - group: root
    - mode: 644

cib_vip_replace:
  file.replace:
    - name: /root/cib.xml
    - repl: "{{ pillar['mssql_vip']  }}"
    - pattern: VIP_VALUE
    - require:
      - file: cib_conf
cib_nm_replace:
  file.replace:
    - name: /root/cib.xml
    - repl: "{{ pillar['netmask']  }}"
    - pattern: NETMASK_VALUE
    - require:
      - file: cib_conf
cib_push:
  cmd.run:
    - name: pcs cluster cib-push /root/cib.xml
    - require:
      - file: cib_nm_replace
      - file: cib_vip_replace
      - service: pacemaker-svc
stonith_disable:
  cmd.run:
    - name:  pcs property set stonith-enabled=false
#This shithead should lay down or ocf resource will fail
reset_mssql:
  cmd.run:
    - name: systemctl disable mssql-server && systemctl stop  mssql-server && chown -R mssql:mssql /var/opt/mssql
remove_&_clean:
  cmd.run:
    - name: sleep 5 && pcs resource cleanup mssql-share &&  sleep 5
    - require:
      - cmd: stonith_disable
      - cmd: reset_mssql
      - service: mssql-server-svc-shut
FCI_clean:
  cmd.run: 
    - name: pcs resource cleanup FCI-mssql
    - require:
      - cmd: remove_&_clean
