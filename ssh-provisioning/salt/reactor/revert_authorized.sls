revert-authorized:
  local.state.apply:
    - tgt: {{ data['id'] }}
    - arg:
      - authorized_reload
