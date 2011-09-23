# encoding: utf-8
require "jay_z/version"
require 'jay_z/blueprint'
module JayZ
  def make(*args)
    JayZ.const_get(name).make(*args)
  end
end
