# encoding: utf-8
require 'minitest/autorun'
require 'jay_z'

module JayZ
  class Blog < Blueprint
    default do
      writer { Writer.make.save }
      body { "I am a default post body" }
    end

    set(:video) do
      writer { Writer.make(:name => 'Anders defined in Blog.video').save }
      url { 'http://www.youtube.com/watch?v=g5950v0kTJg' }
    end
  end

  class Writer < Blueprint
    default do
      name { 'Anders Törnqvist' }
    end
  end
end

class Blog
  extend JayZ
  attr_accessor :writer
  attr_accessor :body
  attr_accessor :url
  def save; 'save in post called'; end
  def save!; self; end
end

class Writer
  extend JayZ
  attr_accessor :name
  def save; self; end
end

describe JayZ do
  describe  "when extending a class with the JayZ module" do
    it "adds a .make method" do
      Blog.make.must_be_instance_of(JayZ::Blog)
    end

    describe ".make" do
      it "creates a blueprint proxy object" do
        Blog.make.must_be_instance_of(JayZ::Blog)
      end
    end

    describe "blueprint proxy object" do
      it "delegate all messages" do
        Blog.make.save.must_equal 'save in post called'
      end
    end

    describe "before it delegates a message" do
      it "populates the receiver with values from the blueprint" do
        Blog.make.save!.body.must_equal 'I am a default post body'
      end
    end

    describe ".make message with a symbol argument" do
      before { @video = Blog.make(:video).save! }
      it "populates the receiver with values defined in the video block" do
        @video.url.must_equal 'http://www.youtube.com/watch?v=g5950v0kTJg'
      end

      it %q{populates the receiver with values from the default block if not
            defined in video block} do
        @video.body.must_equal 'I am a default post body'
      end

      describe "inside a blueprint block" do
        it "can create other objects" do
          @video.writer.name.must_equal 'Anders defined in Blog.video'
        end
      end
    end

  end
end
