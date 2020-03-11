require_relative 'util'

module ClientDataAdapter
  class Wrapper

    # Instance of original class.
    #
    # @example
    #   @book.adapter_wrapper.target == @book # => true
    attr_reader :target

    def initialize(target, &block)
      @target = target

      self.class.module_eval(&block)
    end


    # Main adapter method, should return +Hash+.
    #
    # Syntactic sugar of +with+.
    #
    # @return [Hash]
    # @see with
    # @example
    #   define_adapter do
    #
    #     adapter do
    #       {
    #         id: id,
    #         title: title,
    #       }
    #     end
    #
    #   end
    def self.adapter(&block)
      with('__adapter__', &block)
    end

    # Used in one-to-one relationship.
    #
    # Syntactic sugar of +with+.
    #
    # @param [Symbol] associations
    # @see with
    # @example
    #   define_adapter do
    #
    #     link_one(:link1, :link2)
    #     # ...
    #
    #   end
    def self.link_one(*associations)
      associations.each do |assoc|
        with(assoc) do |*args|
          obj = public_send(assoc.to_sym)

          if obj.respond_to?(:adapter)
            obj.adapter(*args)
          end
        end
      end
    end

    # Used in one-to-many relationship.
    #
    # Syntactic sugar of +with+.
    #
    # @param [Symbol] associations
    # @see with
    # @example
    #   define_adapter do
    #
    #     link_many(:link1, :link2)
    #     # ...
    #
    #   end
    def self.link_many(*associations)
      associations.each do |assoc|
        with(assoc) do |*args|
          (public_send(assoc.to_sym) || []).map do |elem|
            elem.adapter(*args)
          end
        end
      end
    end

    # Define a method of +Wrapper+.
    #
    # Merged to the result of +adapter+ method.
    #
    # @param [Symbol] method_name
    # @example
    #   define_adapter do
    #     # ...
    #
    #     with :something do
    #       # do something
    #     end
    #
    #   end
    def self.with(method_name, &block)
      define_method(method_name.to_sym) do |*args|
        target.instance_exec(
          *args,
          &Util.to_lambda(block)
        )
      end
    end

  end
end
