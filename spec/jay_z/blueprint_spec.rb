# encoding: utf-8
require 'jay_z/blueprint'
require 'minitest/autorun'

module JayZ
  class User < Blueprint; end
  class Comment < Blueprint; end
end

class User
  extend JayZ
  attr_accessor :name
  def self.counter; @counter; end
  def self.counter=(c); @counter = c; end
  def initialize; self.class.counter = 0; end
  def save; self.class.counter += 1; end
end

class Comment
  extend JayZ
  attr_accessor :user
  attr_accessor :body
end

describe JayZ::Blueprint do
  describe ".make" do
    it "creates an instance" do
      JayZ::User.make.must_be_instance_of(JayZ::User)
    end
  end

  describe ".default" do
    before do
      JayZ::User.default do
        name { "User 1" }
      end
    end

    describe "when called with a block" do
      it "saves the block" do
        JayZ::User.default.must_equal :name => 'User 1'
      end
    end

    describe "when called without a block" do
      it "returns a hash" do
        JayZ::User.default.must_equal :name => 'User 1'
      end
    end
  end

  describe ".set" do
    before do
      JayZ::Comment.set(:admin) do
        user { JayZ::User.make(:name => 'Anders Admin').new }
      end
    end

    describe "when called with a block" do
      it "creates a class method specified by the symbol name" do
        JayZ::Comment.admin[:user].name.must_equal 'Anders Admin'
      end

      it "saves the block" do
        JayZ::Comment.admin[:user].name.must_equal 'Anders Admin'
      end
    end

    describe "when called without a block" do
      it "returns a hash" do
        JayZ::Comment.admin[:user].name.must_equal 'Anders Admin'
      end
    end
  end

  describe "when the default block values is used" do
    before do
      JayZ::Comment.default do
        user { User.make(:name => 'Anders Default').new }
        body { 'I am defined in default' }
      end
      JayZ::Comment.set(:spam) do
        user { User.make(:name => 'Anders Spam').new }
      end
    end

    describe "when .set(:spam) has not defined the method in its block" do
      it "returns the body defined in the default block" do
        JayZ::Comment.spam[:body].must_equal 'I am defined in default'
      end
    end
    describe "when .set(:spam) has defined the method in its block" do
      it "returns the value from the spam block" do
        JayZ::Comment.spam[:user].name.must_equal 'Anders Spam'
      end
    end
  end

  describe "serial number interpolation with sn method" do
    before do
      JayZ::User.default do
        name { "User #{sn}" }
      end
      JayZ::User.set(:admin) do
        name { "Admin #{sn}" }
      end
    end

    it "returns the next number for each hash" do
      JayZ::User.admin[:name].must_equal "Admin 1"
      JayZ::User.default[:name].must_equal "User 2"
      JayZ::User.default[:name].must_equal "User 3"
      JayZ::User.admin[:name].must_equal "Admin 4"
    end
  end

  describe "#new" do
    before do
      JayZ::User.default do
        name { 'Anders' }
      end
    end
    it "returns the correct object" do
      JayZ::User.make.new.must_be_instance_of(User)
    end
  end

  describe "when a message is sent to the instance" do
    before do
      JayZ::User.default do
        name { 'Anders' }
      end
      @jayz_user = JayZ::User.make
    end
    it "delegates that message" do
      @jayz_user.save.must_equal 1
    end
  end

  describe "blocks are not executed when defined" do
    before do
      JayZ::User.default do
        name { 'Anders' }
      end
      JayZ::Comment.default do
        user { User.make.save }
      end
    end

    it "executes the block when called" do
      User.counter.must_equal nil
      JayZ::Comment.default
      User.counter.must_equal  1
    end
  end
end
