require_relative 'config'
require_relative 'wrapper'

module ClientDataAdapter
  module ClassMethods

    # @yield define the adapter in the block
    # @example
    #   define_adapter do
    #     # define your adapter here.
    #     # ...
    #   end
    def define_adapter(&block)

      const_set(ADAPTER_WRAPPER, Class.new(Wrapper))

      # Return the wrapper of adapter.
      define_method :adapter_wrapper do
        @__adapter_wrapper__ ||= self.class.const_get(ADAPTER_WRAPPER).new(self, &block)
      end

    end

  end
end