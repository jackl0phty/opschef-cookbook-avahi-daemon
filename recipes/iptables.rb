# Author:: Evin Callahan (gaieges@gmail.com)
# Cookbook Name:: avahi-daemon
# Recipe:: iptables

include_recipe "iptables"
iptables_rule "avahi"