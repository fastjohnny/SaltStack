include:
  - kubernetes.common
kubernetes:
  pool:
    container: false
    verbosity: 2
    network:
        engine: flannel
        etcd:
          members:
            - host: 10.254.68.50
              port: 4001
            - host: 10.254.68.51
              port: 4001
            - host: 10.254.68.52
              port: 4001
