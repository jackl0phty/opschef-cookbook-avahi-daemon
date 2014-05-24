#
# Cookbook Name:: avahi-daemon
# Recipe:: enable
#
# Copyright 2012, Gerald L. Hevener Jr., M.S.
#

# Install server components for Debian
case node['platform_family']
  when "debian"
    %w{ avahi-daemon libnss-mdns }.each do |pkg|
    package pkg do
      action :install
    end
  end
end

template node['avahi-daemon']['service']['config'] do
  source 'avahi-daemon.conf.erb'
  owner 'root'
  group 'root'
  mode  '0644'
  notifies :restart, "service[#{node['avahi-daemon']['service']['name']}]", :delayed
end

# It will be .local by default
template '/etc/mdns.allow' do
  source 'mdns.allow.erb'
  owner 'root'
  group 'root'
  mode  '0644'
  only_if { node['avahi-daemon']['mdns-allow'] }
end

# Start & enable the avahi-daemon service
service "avahi-daemon" do
  service_name node['avahi-daemon']['service']['name']
  action [ :start, :enable ]
end
