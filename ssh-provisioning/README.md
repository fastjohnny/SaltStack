### Salt SSH provisioning  
### Main Goal  
This repo provides sls files and configs for full ssh provisioning - 
disable password auth, add keys, configure fail2ban and etc.  
runners/reactors and beacons provide sshd\_config and authorized\_keys immutabilty  

### How to use  
1. Log into your minion VM  
2. Copy-paste deploy-minion.sh, execute  
3. Log into your master salt VM, accept key   
``salt-key -L; salt-key -A _host_``    
4. Point in master config to salt/ dir as base and /pillar di as pillar  
5. Create pillar/myuser.sls file with new user  
6. Update pillar/top.sls and salt/top.sls files - add your host, choose create\_users.sls for it    
7. Copy master\_reactor.conf to /etc/salt/master.d/reactor.conf, change paths   
8. Change 'master: ' option in /etc/salt/master.conf  
9. systemct restart salt-master  
10. Add ssh public key to salt/ssh\_keys/  directory. Filename format is user.pub  
11. Run  
``salt _host_ state.apply``  

### Debugging  
On Master  
``salt-run state.event pretty=True #Pay attention to tags of cp.push and beacons``  
``salt-master -l debug``  
``ls -la /var/cache/salt/master/minions/_host_/files/.... #Where you can find authorized_keys from hosts, if not - your inotify on minions not working``  
``ls -la salt/authorized_keys/..... #If there is nothing then your runner is not working``  
``vim /var/log/syslog #you can  find some debugging info from runners``  
On minion  
``salt-call event.send 'custom/tag' #send custom tag from minion. Useful in combination with ``salt-run state.event pretty=True`` on master  
