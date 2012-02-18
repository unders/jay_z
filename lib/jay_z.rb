# encoding: utf-8
require "jay_z/version"
require 'jay_z/blueprint'

module JayZ
  def self.Blueprint(jayz_module)
    Class.new(Blueprint) do
      include jayz_module
    end
  end

  def make(*args)
    name.split('::').inject(JayZ) do |klass_level, name|
      klass_level.const_get(name)
    end.make(*args)
  end

  module ProxyMethods
    def new
      if @object.valid?
        @object
      else
        fail ActiveRecord::RecordInvalid.new(@object)
      end
    end

    def new!
      @object
    end

    def save
      @object.tap { |record| record.save! }
    end
  end
end
