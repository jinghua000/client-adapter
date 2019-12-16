require_relative 'client-data-adapter/class_methods'
require_relative 'client-data-adapter/instance_methods'
require_relative 'client-data-adapter/version'

# For unify data formats to transfer to clients.
#
# Homepage https://github.com/jinghua000/client-data-adapter
#
# @author shadow <https://github.com/jinghua000>
module ClientDataAdapter

  def self.included(base)
    base.include(ClientDataAdapter::InstanceMethods)
    base.extend(ClientDataAdapter::ClassMethods)
  end

end
