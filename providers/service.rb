def whyrun_supported?
  true
end

use_inline_resources

action :create do
  template "/etc/avahi/services/#{new_resource.name}.service" do
    source 'service.erb'
    cookbook 'avahi-daemon'
    mode new_resource.mode
    owner new_resource.owner
    group new_resource.group

    variables({
      :name => new_resource.name,
      :network_name => new_resource.network_name,
      :replace_wildcards => new_resource.replace_wildcards,
      :services => new_resource.services
    })
  end
end

action :delete do
  template "/etc/avahi/services/#{new_resource.name}.service" do
    action :delete
  end
end
