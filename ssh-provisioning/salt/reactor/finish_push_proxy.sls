dopush:
  runner.dopush.push_proxy:
     - host: {{ data['id'] }}
     - user: {{data['data']['ret']['__id__']}}
