#hosts
master-hosts-entry:
  host.present:
    - ip: {{ pillar['master_ip'] }}
    - names:
      - {{ pillar['master_hostname'] }}
slave1-hosts-entry:
  host.present:
    - ip: {{ pillar['slave1_ip'] }}
    - names:
      - {{ pillar['slave1_hostname'] }}
slave2-hosts-entry:
  host.present:
    - ip: {{ pillar['slave2_ip'] }}
    - names:
      - {{ pillar['slave2_hostname'] }}
