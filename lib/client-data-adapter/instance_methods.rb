require_relative 'util'

module ClientDataAdapter
  module InstanceMethods

    def adapter(*args)

      length = args.length

      if length == 0
        adapter_wrapper.__adapter__
      else
        adapter_wrapper.__adapter__.merge(

          *args.map do |arg|
            key, params = Util.format_available_types(arg)

            {}.tap do |hah|
              hah["#{key}".to_sym] =
                adapter_wrapper.respond_to?(key) ?
                  adapter_wrapper.public_send(key, *params) :
                  public_send(key, *params)
            end
          end

        )
      end
    end

  end
end
