require_relative 'util'

module ClientDataAdapter
  class Wrapper

    attr_reader :target

    def initialize(target, &block)
      @target = target

      self.class.module_eval(&block)
    end

    def self.adapter(&block)
      __do__('__adapter__', &block)
    end

    def self.__do__(method_name, &block)
      define_method(method_name.to_sym) do |*args|
        target.instance_exec(
          *args,
          &Util.to_lambda(block)
        )
      end
    end

    class << self
      alias_method :with, :__do__
    end

  end
end
