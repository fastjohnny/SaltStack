mssql:
  user.present:
    - fullname: Mssql Service User
    - home: /var/opt/mssql
    - groups:
      - wheel
    - require:
        - pkg: mssql-server-2017-pkg

/var/opt/mssql/secrets:
  file.directory:
    - user: mssql
    - group: mssql
    - mode: 755
    - makedirs: True

/var/opt/mssql:
  file.directory:
    - user: mssql
    - group: mssql
    - mode: 755 # some permission    
    - recurse:
      - user
      - group
    - require:
      - user: mssql
      - file: /var/opt/mssql/secrets

/opt/mssql/bin/sqlservr:
  file.managed:
    - user: mssql
    - group: mssql
    - mode: 755 # some permission
    - require:
      - file: /var/opt/mssql

update_daemon:
  file.line:
    - name: /usr/lib/systemd/system/mssql-server.service
    - mode: replace
    - content: ExecStart=/opt/mssql/bin/sqlservr --accept-eula
    - match: ExecStart=/opt/mssql/bin/sqlservr
    - require:
      - pkg: mssql-server-2017-pkg

mssql-server-svc-shut:
  service.dead:
    - name: mssql-server
    - enable: False
    - require:
      - file: /opt/mssql/bin/sqlservr

mssql_conf:
  cmd.run:
    - name: MSSQL_PID=Developer ACCEPT_EULA=Y MSSQL_SA_PASSWORD='{{ pillar["SA_passwd"] }}' /opt/mssql/bin/mssql-conf -n setup
    - require:
      - service: mssql-server-svc-shut

secret_mssql:
  file.managed:
    - name: /var/opt/mssql/secrets/passwd
    - contents: |
        SA
        {{ pillar['SA_passwd'] }}
    - require:
      - cmd: mssql_conf
