{% if grains.id == 'skl-ssh-proxy-101' %}
/home/proxy-user/.ssh/authorized_keys:
  file.managed:
    - source: salt://authorized/minions/{{grains.id}}/home/proxy-user/.ssh/authorized_keys
    - user: proxy-user
    - group: proxy-user
    - mode: 600
{% else %}
{% for user, args in pillar['users'].iteritems() %}
{% if 'key_pub' in args and args['key_pub'] == True %}
/home/{{user}}/.ssh/authorized_keys:
  file.managed:
    - source: salt://authorized/minions/{{grains.id}}/home/{{user}}/.ssh/authorized_keys
    - user: {{user}}
    - group: {{user}}
    - mode: 600
{% endif %}
{% endfor %}
{% endif %}
