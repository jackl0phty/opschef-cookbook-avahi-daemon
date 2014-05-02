def whyrun_supported?
  true
end

use_inline_resources

action :create do

  service "avahi-daemon" do
    service_name node['avahi-daemon']['service']['name']
    action :nothing
  end

  template "/etc/avahi/services/#{new_resource.name}.service" do
    source 'service.erb'
    cookbook 'avahi-daemon'
    mode new_resource.mode
    owner new_resource.owner
    group new_resource.group

    variables({
      :network_name => new_resource.network_name,
      :replace_wildcards => new_resource.replace_wildcards,
      :services => new_resource.services
    })

    notifies :restart, 'service[avahi-daemon]'
  end

  new_resource.updated_by_last_action(true)
end

action :delete do

  service "avahi-daemon" do
    service_name node['avahi-daemon']['service']['name']
    action :nothing
  end

  template "/etc/avahi/services/#{new_resource.name}.service" do
    source 'service.erb'
    cookbook 'avahi-daemon'
    mode new_resource.mode
    owner new_resource.owner
    group new_resource.group

    action :delete

    notifies :restart, 'service[avahi-daemon]'
  end
end
