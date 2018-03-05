#repos and pkgs
mirror-msprod:
  pkgrepo.managed:
    - humanname: Microsoft Packages production RHEL 7
    - name: msprod
    - baseurl: https://xxx.xxxx.xxx/msprod/
    - gpgcheck: 0
mirror-mssql-server-2017:
  pkgrepo.managed:
    - humanname: MS SQL Server 2017 RHEL 7
    - name: mssql-server-2017
    - baseurl: https://xxx.xxxx.xxx/mssql-server-2017/
    - gpgcheck: 0
mssql-server-2017-pkg:
  pkg.installed:
    - pkgs:
      - mssql-server
#      - mssql-server-agent  - not sure, salt tells that the package is obsolete by mssql-server-14
      - mssql-server-fts
      - pcs
      - corosync
      - mssql-server-ha
      - pacemaker
      - unixODBC-devel
    - require:
      - pkgrepo: mirror-msprod
      - pkgrepo: mirror-mssql-server-2017
