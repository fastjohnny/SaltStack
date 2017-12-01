{% for user, args in pillar['users'].iteritems() %}
{{ user }}_key:
  ssh_auth:
    - present
    - user: proxy-user
    - source: salt://ssh_keys/{{ user }}.pub
  module.run:
    - name: cp.push_dir
    - path: /home/proxy-user/.ssh
    - fire_event: finish_push_proxy
{% endfor %}
beacons_file_proxy:
    file.managed:
      - name: /etc/salt/minion.d/beacons.conf
      - source: salt://templates/beacons.conf
      - template: jinja

minion_restart_proxy:
    service.running:
      - name: salt-minion
      - enable: True
      - restart: True
