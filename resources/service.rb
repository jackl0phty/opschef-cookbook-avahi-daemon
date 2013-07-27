
actions :create, :delete

default_action :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :network_name, :kind_of => String, :default => '%h'
attribute :owner, :kind_of => String, :default => 'root'
attribute :group, :kind_of => String, :default => 'root'
attribute :mode, :kind_of => Fixnum, :default => 0644
attribute :replace_wildcards, :kind_of => [TrueClass, FalseClass], :default => true
attribute :services, :kind_of => Array, :callbacks => {
  "should contain an array of hashes with valid service variables" => ->(services) {
    Chef::Resource::AvahiDaemonService.validate_services(services)
  }
}

private
  def self.validate_services(services)
    return false unless services.reject { |service|
      return false unless service.instance_of? Hash

      required_parameters = { :type => String, :port => Fixnum }
      optional_parameters = { :domain_name => String, :host_name => String, :protocol => String }

      return false unless required_parameters.reject { |key, value|
        return service.has_key?(key) && service[key].instance_of?(value)
      }.empty?
      return false unless optional_parameters.reject { |key, value|
        return service.has_key?(key) && service[key].instance_of?(value)
      }.empty?

      if service.has_key? 'txt_records'
        return false unless service['txt_records'].instance_of? Array
        return false unless service['txt_records'].reject { |record|
          return record.instance_of? String
        }.empty?
      end

      if service.has_key? 'sub_types'
        return false unless service['sub_types'].instance_of? Array
        return false unless service['sub_types'].reject { |sub_type|
          return sub_type.instance_of? String
        }.empty?
      end

      return true
    }.empty?

    return true
  end
