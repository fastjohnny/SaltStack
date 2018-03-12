#Downloading plugins
update_locale:
  file.managed:
    - name: /etc/locale.conf
    - contents:
      - LANG=en_US.utf8
      - LC_ALL=en_US.UTF-8

wget_plugins:
  cmd.run:
    - name: |
        export http_proxy=http://10.254.1.15:3128 ; export https_proxy=http://10.254.1.15:3128
        wget https://dl.bintray.com/rabbitmq/community-plugins/3.7.x/rabbitmq_delayed_message_exchange/rabbitmq_delayed_message_exchange-20171201-3.7.x.zip \
        -O temp.zip; unzip temp.zip -d /usr/lib/rabbitmq/lib/rabbitmq_server-3.7.2/plugins/; rm -rf temp.zip
        wget https://github.com/deadtrickster/prometheus_rabbitmq_exporter/releases/download/v3.7.2.1/accept-0.3.3.ez \
        -O /usr/lib/rabbitmq/lib/rabbitmq_server-3.7.2/plugins/accept-0.3.3.ez
        wget https://github.com/deadtrickster/prometheus_rabbitmq_exporter/releases/download/v3.7.2.1/prometheus-3.4.5.ez \
        -O /usr/lib/rabbitmq/lib/rabbitmq_server-3.7.2/plugins/prometheus-3.4.5.ez
        wget https://github.com/deadtrickster/prometheus_rabbitmq_exporter/releases/download/v3.7.2.1/prometheus_cowboy-0.1.4.ez \
        -O /usr/lib/rabbitmq/lib/rabbitmq_server-3.7.2/plugins/prometheus_cowboy-0.1.4.ez
        wget https://github.com/deadtrickster/prometheus_rabbitmq_exporter/releases/download/v3.7.2.1/prometheus_httpd-2.1.8.ez \
        -O /usr/lib/rabbitmq/lib/rabbitmq_server-3.7.2/plugins/prometheus_httpd-2.1.8.ez
        wget https://github.com/deadtrickster/prometheus_rabbitmq_exporter/releases/download/v3.7.2.1/prometheus_process_collector-1.3.1.ez \
        -O /usr/lib/rabbitmq/lib/rabbitmq_server-3.7.2/plugins/prometheus_process_collector-1.3.1.ez
        wget https://github.com/deadtrickster/prometheus_rabbitmq_exporter/releases/download/v3.7.2.1/prometheus_rabbitmq_exporter-v3.7.2.1.ez \
        -O /usr/lib/rabbitmq/lib/rabbitmq_server-3.7.2/plugins/prometheus_rabbitmq_exporter-v3.7.1.1.ez
    - require:
      - pkg: rabbitmq-pkg
      - file: update_locale
#Enabling plugins
enabled_rabbitmq_accept:
  rabbitmq_plugin.enabled:
    - name: accept
    - onlyif: test -e /usr/sbin/rabbitmq-plugins
    - require:
      - pkg: rabbitmq-pkg
      - cmd: wget_plugins

enabled_rabbitmq_prometheus:
  rabbitmq_plugin.enabled:
    - name: prometheus
    - onlyif: test -e /usr/sbin/rabbitmq-plugins
    - require:
      - pkg: rabbitmq-pkg
      - cmd: wget_plugins

enabled_rabbitmq_prometheus_cowboy:
  rabbitmq_plugin.enabled:
    - name: prometheus_cowboy
    - onlyif: test -e /usr/sbin/rabbitmq-plugins
    - require:
      - pkg: rabbitmq-pkg
      - cmd: wget_plugins

enabled_rabbitmq_prometheus_httpd:
  rabbitmq_plugin.enabled:
    - name: prometheus_httpd
    - onlyif: test -e /usr/sbin/rabbitmq-plugins
    - require:
      - pkg: rabbitmq-pkg
      - cmd: wget_plugins

enabled_rabbitmq_prometheus_process_collector:
  rabbitmq_plugin.enabled:
    - name: prometheus_process_collector
    - onlyif: test -e /usr/sbin/rabbitmq-plugins
    - require:
      - pkg: rabbitmq-pkg
      - cmd: wget_plugins

enabled_rabbitmq_prometheus_rabbitmq_exporter:
  rabbitmq_plugin.enabled:
    - name: prometheus_rabbitmq_exporter
    - onlyif: test -e /usr/sbin/rabbitmq-plugins
    - require:
      - pkg: rabbitmq-pkg
      - cmd: wget_plugins

enabled_rabbitmq_plugin_delayed_message_exchange:
  rabbitmq_plugin.enabled:
    - name: rabbitmq_delayed_message_exchange
    - onlyif: test -e /usr/sbin/rabbitmq-plugins
    - require:
      - pkg: rabbitmq-pkg
      - cmd: wget_plugins
enabled_rabbitmq_management:
  rabbitmq_plugin.enabled:
    - name: rabbitmq_management
    - onlyif: test -e /usr/sbin/rabbitmq-plugins
    - require:
        - pkg: rabbitmq-pkg
