#Starting LVM partitioning
{{ pillar['blk'] }}:
  lvm.pv_present

mssql-vg:
  lvm.vg_present:
    - devices: {{ pillar['blk'] }}

mssql-lv:
  lvm.lv_present:
    - vgname: mssql-vg
    - extents: '100%FREE'

make_xfs:
  cmd.run:
    - name: blkid /dev/mapper/mssql--vg-mssql--lv; if [[ $? != 0 ]]; then  mkfs.xfs /dev/mapper/mssql--vg-mssql--lv; fi
    - require:
      - lvm: mssql-lv
