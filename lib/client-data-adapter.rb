require_relative 'client-data-adapter/class_methods'
require_relative 'client-data-adapter/instance_methods'

module ClientDataAdapter

  def self.included(base)
    base.include(ClientDataAdapter::InstanceMethods)
    base.extend(ClientDataAdapter::ClassMethods)
  end

end
