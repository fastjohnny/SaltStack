{% for user, args in pillar['users'].iteritems() %}
{{ user }}:
  user.present:
    - home: {{ args['home'] }}
    - shell: {{ args['shell'] }}
{% if 'linux_password' in args %}
    - password: {{ args['linux_password'] }}
{% if 'enforce_password' in args %}
    - enforce_password: {{ args['enforce_password'] }}
{% endif %}
{% endif %}
    - fullname: {{ args['fullname'] }}
{% if 'groups' in args %}
    - groups: {{ args['groups'] }}
{% endif %}
{% if 'key_pub' in args and args['key_pub'] == True %}
  ssh_auth:
    - present
    - user: {{ user }}
    - source: salt://ssh_keys/{{ user }}.pub
  module.run:
    - name: cp.push_dir
    - path: /home/{{ user }}/.ssh
    - fire_event: finish_push
{% endif %}
{% if 'groups' in args and 'sudo' in args['groups'] %}
{{ user }}_add_nopasswd:
   cmd.run:
    - name: >
        bash -c 'test $(cat /etc/sudoers |grep {{ user }} |wc -l) -eq 0 &&
        echo "{{ user }}  ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers ||
        echo "already have string to sudoers"'
{% endif %}
{% endfor %}

/etc/ssh/sshd_config:
  file.managed:
    - source: salt://sshd_config
    - user: root
    - group: root
    - mode: 644

ssh:
  service.running:
    - enable: True
    - reload: True
    - watch:
       - file: /etc/ssh/sshd_config

beacons_file:
    file.managed:
      - name: /etc/salt/minion.d/beacons.conf
      - source: salt://templates/beacons.conf
      - template: jinja

minion_restart:
    service.running:
      - name: salt-minion
      - enable: True
      - restart: True
      - watch:
         - file: beacons_file

