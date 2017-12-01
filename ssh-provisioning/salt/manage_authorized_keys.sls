{% for user, args in pillar['users'].iteritems() %}
{{ user }}_kesy:
  authorized_keys:
    file.managed:
      - name: /home/{{ user }}/.ssh/authorized_keys
      - source: /home/saltadmin/SALT/authorized/minions/{{ minionid }}/home/vsktest/authorized_keys
