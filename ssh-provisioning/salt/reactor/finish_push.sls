dopush:
  runner.dopush.push:
     - host: {{ data['id'] }}
     - user: {{data['data']['ret']['__id__']}}
