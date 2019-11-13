module ClientDataAdapter
  module Util

    module_function

    # Merge some hash.
    #
    # @param [Hash] elements
    def merge(*elements)
      {}.tap do |hsh|
        elements.each do |elem|
          elem.each do |k, v|
            hsh[k] = v
          end
        end
      end
    end

    # Convert a Proc to Lambda.
    #
    # @param [Proc] source_proc
    # @return [Lambda]
    def to_lambda(source_proc)
      return source_proc if source_proc.lambda?

      unbound_method = Module.new.module_eval do
        instance_method(define_method(:_, &source_proc))
      end

      lambda do |*args, &block|
        unbound_method.bind(self).call(*args, &block)
      end
    end

  end
end
