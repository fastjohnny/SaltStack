revert-file:
  local.state.apply:
    - tgt: {{ data['id'] }}
    - arg:
      - manage_sshd_config
