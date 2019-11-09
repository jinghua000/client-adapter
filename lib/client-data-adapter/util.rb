module ClientDataAdapter
  module Util

    module_function

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

    def format_available_types(arg)
      if [String, Symbol].include?(arg.class)

        [arg.to_sym, nil]

      elsif arg.is_a?(Hash)

        arg.keys.first.yield_self do |k|
          [k, arg[k]]
        end

      else
        raise '[ERROR] Not available arguments type.'
      end
    end

  end
end
