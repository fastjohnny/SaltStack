# SaltStack  
## States in Repo  
--------
### MsSQL 2017 HA cluster    
#### Disclaimer  
Manifests were tested only with a CentOs7 distro   
#### Info  
Deploys HA MSSQL Active-Passive cluster on two CenOS7 nodes   
#### How it works  
Deploys on each node:  
- mssql-server and other related mssql stuff  
- pacemaker/corosync/mssql-ocf/etc...  
Configures:  
- LVM on block device, xfs  
- cib  with 2 nodes and 3 resources - VIP, share, FCI  
- mssql SA account  
Starts cluster, disables mssql-server daemon, changes ownership and etc....
#### Prereq  
1. Create and attach shared block device to both VM's  
2. Create local MsSQL repo with MsSQL 2017 packages  
3. Update repo settings in states/mssql/packages.sls  
4. Allocate 3 IP's in your network - for the each vm and VIP  
5. Update pillar/mssql.sls file  
#### Run  
```salt 'ms*' state.apply mssql```  
--------
### SSH-provisioning bundle  
#### Disclaimer  
Manifests were tested both on debian/centos-like systems   
#### Info   
Configures ssh-provisioning system both on minion and master.  
Creates users with ssh-rsa keys, enforces ssh-rsa auth, guarantee  
immutability of ssh configs on each minion.  
#### How it works  
Deploys on each node:  
- Users wih keys  
- fail2ban package  
Configures:  
- sshd_config   
- authorized_keys   
- reactor config on salt-master  
- runners on salt-master  
- beacon files on minions    
After applying state, msater begins polling minion for each file mentioned in reactor config.  
State itself configures all needed configs on minion side - beacons and salt-minion config.  
Then state applies all /home/*/.ssh/authorirez_keys and /etc/ssh/sshd_conf configs will be watched by salt master.  
#### Prereq  
1. Setup master_reactor.conf on salt master  
2. Configure ypur master to watch _runners dir   
3. Prepare your minion by running script deploy_minion.sh  
4. Configure your pillar/top.sls pillar/vmname.sls states/top.sls files -  
Enable or Disable linux/create_users manifests  
#### Run  
```salt 'vm1' state.apply``` 
