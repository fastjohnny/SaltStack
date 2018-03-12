kubernetes:
    common:
      kubernetes_cluster_domain: k8s-test.digital.bank
      cluster_name : nutanix
      hyperkube:
        image: gcr.art.3adigital.ru/google_containers/hyperkube:v1.8.2
      network:
        engine: flannel
      addons:
        helm:
          enabled: true
        netchecker:
          enabled: true
        coredns:
          enabled: True
        externaldns:
          enabled: True
          domain: k8s-test.digital.bank
          provider: coredns
