require_relative 'util'

module ClientDataAdapter
  module InstanceMethods

    # Main adapter method.
    #
    # @param args [Symbol|String|Hash]
    # @example
    #   @book.adapter(:method1, method2: 'payload', method3: [:foo, :bar])
    def adapter(*args)

      length = args.length

      if length == 0
        adapter_wrapper.__adapter__
      else
        Util.merge(
          adapter_wrapper.__adapter__,
          *args.map do |arg|
            if [String, Symbol].include?(arg.class)
              __merge_to_adapter__(arg.to_sym, nil)
            elsif arg.is_a?(Hash)
              arg.map { |k, v| __merge_to_adapter__(k, v) }
            else
              raise '[ERROR] Not available arguments type.'
            end
          end.flatten,
        )
      end
    end

    private

    def __merge_to_adapter__(key, params)
      {}.tap do |hah|
        hah["#{key}".to_sym] =
          adapter_wrapper.respond_to?(key) ?
            adapter_wrapper.public_send(key, *params) :
            public_send(key, *params)
      end
    end

  end
end
