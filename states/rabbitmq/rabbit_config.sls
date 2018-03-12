{% set the_node_name = salt['grains.get']('nodename', '') %}
{% set the_master_name = salt['pillar.get']('master_hostname', '') %}

{% if the_node_name == the_master_name %}

{% for users, args in pillar['rabbit_users'].iteritems() %}
rabbitmq_{{ users }}_present:
  rabbitmq_user.present:
    - name: {{ args['name'] }}
    - password: {{ args['password'] }}
    - force: True
    - tags:
      - administrator
    - perms:
      - '/':
        - '.*'
        - '.*'
        - '.*'
    - runas: root
    - require:
        - service: rabbitmq-svc
{% endfor %}

{% for vhost in pillar['vhosts'] %}
rabbitq_vhost_{{ vhost['name'] }}_present:
 rabbitmq_vhost.present:
    - runas: root
    - name: {{ vhost['name'] }}
    - require:
      - service: rabbitmq-svc

rabbit_{{ vhost['name'] }}_policy:
  rabbitmq_policy.present:
    - name: HA
    - pattern: '.*'
    - definition: '{"ha-mode":"all","ha-sync-mode":"automatic", "queue-master-locator":"client-local"}'
    - vhost: {{ vhost['name'] }}
{% endfor %}

#For / vhost
rabbit_root_policy:
  rabbitmq_policy.present:
    - name: HA
    - pattern: '.*'
    - definition: '{"ha-mode":"all","ha-sync-mode":"automatic", "queue-master-locator":"client-local"}'
    - vhost: /

rabbitmq_delete_guest:
  rabbitmq_user.absent:
    - runas: root
    - name: guest
    - require:
      - service: rabbitmq-svc
{% endif %}
