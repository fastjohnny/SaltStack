include:
  - kubernetes.common
kubernetes:
  master:
    container: false
    verbosity: 2
    apiserver:
      secure_port: 8081
    namespace:
      netchecker:
        enabled: true
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
