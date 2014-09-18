

Travis-ci status: [![Build Status](https://secure.travis-ci.org/jackl0phty/opschef-cookbook-avahi-daemon.png?branch=master)](http://travis-ci.org/jackl0phty/opschef-cookbook-avahi-daemon) 

Description
===========

Installs/enables or Uninstalls/disables the avahi-daemon service.

Requirements
============

This cookbook currently supports the following platforms:

Debian, Ubuntu, Raspbian

Attributes
==========

Set the avahi-daemon service name.
<pre><code>default['avahi-daemon']['service']['name'] = "avahi-daemon"</pre></code>

Set the avahi-daemon config filename.
<pre><code>
default['avahi-daemon']['service']['config'] = "/etc/avahi/avahi-daemon.conf"
</pre></code>

Comma separated list of domains to lookup with with mDNS. Will be /etc/mdns.allow content. 
If not defined no file will be created, and only .local domain is
used. Put '*' to allow any domain lookup.
<pre><code>
node['avahi-daemon']['mdns-allow']
</pre></code>

Set config file values.
Use node['avahi-daemon'][config_section][config_parameter] = "value"
syntax. Please see `man avahi-daemon.conf` for details.

Example:
<pre><code>
node['avahi-daemon']['server']['use-ipv4'] = "no"
</pre></code>


Usage
=====

Apply recipe avahi-daemon::enable to install/enable all avahi-daemon related services.

Recipe avahi-daemon::default takes no action.

avahi-daemon::disable recipe
============================

Use a knife command to remove avahi-daemon components from your system like so

knife node run_list add <node name> avahi-daemon::disable 

Resources
=========

The `avahi_daemon_service` resource can be used to generate /etc/avahi/services/\*.service files.  This will tell Avahi what services to advertise.

For example:

<pre><code>
avahi_daemon_service 'afpd' do
  services [
    {
      :type => '_afpovertcp._tcp',
      :port => 548
    },
    {
      :type => '_device-info._tcp',
      :port => 0,
      :txt_records => ['model=Xserve']
    }]
end
</pre></code>
