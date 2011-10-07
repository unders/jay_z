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
    JayZ.const_get(name).make(*args)
  end

  module ActiveRecord
    def new
      if @object.valid?
        @object
      else
        fail ::ActiveRecord::RecordInvalid.new(@object)
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
