require_relative 'util'

module ClientDataAdapter
  class Wrapper

    attr_reader :target

    def initialize(target, &block)
      @target = target

      self.class.module_eval(&block)
    end

    def self.adapter(&block)
      with('__adapter__', &block)
    end

    def self.link_one(*associations)
      associations.each do |assoc|
        with(assoc) do |*args|
          public_send(assoc.to_sym).adapter(*args)
        end
      end
    end

    def self.link_many(*associations)
      associations.each do |assoc|
        with(assoc) do |*args|
          public_send(assoc.to_sym).map do |elem|
            elem.adapter(*args)
          end
        end
      end
    end

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
