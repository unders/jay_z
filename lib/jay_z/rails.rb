require 'jay_z'

module JayZ
  class Railtie < Rails::Railtie
    config.after_initialize do
      blueprints = [ File.join(Rails.root, 'test', 'blueprint'),
                     File.join(Rails.root, 'spec', 'blueprint')]
       blueprints.each do |path|
         if File.exists?("#{path}.rb")
           load("#{path}.rb")
           break
         end
      end
    end
  end
end

ActiveRecord::Base.extend(JayZ)

JayZ::Blueprint.class_eval do
  def new
    if @object.valid?
      @object
    else
      raise ActiveRecord::RecordInvalid.new(@object)
    end
  end

  def new!
    @object
  end

  def save
    @object.tap { |record| record.save! }
  end

  def save!
    @object.tap { |record| record.save(:validate => false) }
  end

  def method_missing(method, *args, &block); super; end
  def respond_to_missing?(method, *); super; end
end
