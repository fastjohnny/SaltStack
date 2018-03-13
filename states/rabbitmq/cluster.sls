{% set the_node_name = salt['grains.get']('nodename', '') %}
{% set the_master_name = salt['pillar.get']('master_hostname', '') %}

advanced_config:
  file.managed:
    - name: /etc/rabbitmq/advanced.config
    - user: rabbitmq
    - group: rabbitmq
    - mode: 644
    - contents: |
        [
          {kernel, [{net_ticktime,  10}]}
        ].
    - require: 
      - pkg: rabbitmq-pkg

rabbitmq_config:
  file.managed:
    - name: /etc/rabbitmq/rabbitmq.conf
    - user: rabbitmq
    - group: rabbitmq
    - mode: 644
    - contents: cluster_partition_handling = autoheal
    - require:
      - pkg: rabbitmq-pkg

erlang_cookie:
  file.managed:
    - name: /var/lib/rabbitmq/.erlang.cookie
    - user: rabbitmq
    - group: rabbitmq
    - mode: 400
    - contents: {{ pillar['erlang_cookie'] }}

update_rabbit_daemon:
  file.line:
    - name: /usr/lib/systemd/system/rabbitmq-server.service
    - mode: replace
    - content: LimitNOFILE=65536
    - match: '# LimitNOFILE=16384'
    - require:
      - pkg: rabbitmq-pkg

reload_daemons:
  cmd.run:
    - name: systemctl daemon-reload
    - require:
      - file: update_rabbit_daemon

rabbitmq-svc:
  service.running:
    - name: rabbitmq-server
    - enable: True
    - require:
      - file: erlang_cookie
      - cmd: reload_daemons
    - watch:
      - file: erlang_cookie
      - file: advanced_config
      - file: rabbitmq_config
      - file: update_rabbit_daemon

{% if the_node_name != the_master_name %}
rabbit@the_node_name:
  rabbitmq_cluster.join:
    - user: rabbit
    - host: {{ pillar['master_hostname'] }}
    - require: 
      - file: erlang_cookie
      - service: rabbitmq-svc
{% endif %}
