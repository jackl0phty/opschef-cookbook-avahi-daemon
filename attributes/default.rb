#
# Cookbook Name:: avahi-daemon
# Recipe:: default
#
# Copyright 2012, Gerald L. Hevener Jr., M.S.
#

# Set the avahi-daemon service and config names
default['avahi-daemon']['service']['name'] = "avahi-daemon"
default['avahi-daemon']['service']['config'] = "/etc/avahi/avahi-daemon.conf"

# Set default configuration values
default['avahi-daemon']['server']['use-ipv4'] = "yes"
default['avahi-daemon']['server']['use-ipv6'] = "yes"
default['avahi-daemon']['server']['ratelimit-interval-usec'] = 1000000
default['avahi-daemon']['server']['ratelimit-burst'] = 1000
default['avahi-daemon']['wide-area']['enable-wide-area'] = 'yes'
default['avahi-daemon']['rlimits']['rlimit-core'] = 0
default['avahi-daemon']['rlimits']['rlimit-data'] = 4194304
default['avahi-daemon']['rlimits']['rlimit-fsize'] = 0
default['avahi-daemon']['rlimits']['rlimit-nofile'] = 768
default['avahi-daemon']['rlimits']['rlimit-stack'] = 4194304
default['avahi-daemon']['rlimits']['rlimit-nproc'] = 3
