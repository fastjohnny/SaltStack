#!/usr/bin/python
import os
import logging
import logging.handlers
import distutils
from distutils import dir_util
my_logger = logging.getLogger('MyLogger')
my_logger.setLevel(logging.DEBUG)

handler = logging.handlers.SysLogHandler(address = '/dev/log')
my_logger.addHandler(handler)
def push(host, user):
    dst='/home/saltadmin/SALT/salt/authorized/minions/{0}/home/{1}/.ssh'.format(host,user)
    src='/var/cache/salt/master/minions/{0}/files/home/{1}/.ssh'.format(host,user)
    my_logger.debug('host:{0}, user:{1}, src:{2}, dst:{3}'.format(host, user, src, dst))
    if not os.path.exists(dst):
       os.makedirs(dst)
    distutils.dir_util.copy_tree(src, dst)
    return
def push_proxy():
    dst_prx='/home/saltadmin/SALT/salt/authorized/minions/skl-ssh-proxy-101/home/proxy-user/.ssh'
    src_prx='/var/cache/salt/master/minions/skl-ssh-proxy-101/files/home/proxy-user/.ssh'
    my_logger.debug('src:{0}, dst:{1}'.format(src_prx, dst_prx))
    if not os.path.exists(dst_prx):
       os.makedirs(dst_prx)
    distutils.dir_util.copy_tree(src_prx, dst_prx)
    return
