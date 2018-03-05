#hosts
master-hosts-entry:
  host.present:
    - ip: {{ pillar['master_ip'] }}
    - names:
      - {{ pillar['master_hostname'] }}
slave-hosts-entry:
  host.present:
    - ip: {{ pillar['slave_ip'] }}
    - names:
      - {{ pillar['slave_hostname'] }}
/etc/hosts:
  file.prepend:
    - text: 127.0.0.1   FCI-mssql
