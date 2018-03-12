base:
  '*':
    - warning_header
    - admins
  'dev-testing':
    - testing
  'vault-test':
    - vault-test
  'k8s-roles:etcd':
    - match: grain
    - kubernetes.etcd_cluster
  '*-DB':
    - mssql
  '*-RMQ':
    - rabbitmq

