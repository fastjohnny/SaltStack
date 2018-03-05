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
``salt 'ms\*' state.apply mssql``  
--------
### SSH-provisioning bundle  
#### Disclaimer  
Manifests were tested both on debian/centos-like systems  
#### Info  
Configures ssh-provisioning system both on minion and master.  
Creates users with ssh-rsa keys, enforces ssh-rsa auth, guarantee  
immutability of ssh configs of each minion.  
####
Salt checks in an automatic mode diff between ssh configs on minion 
