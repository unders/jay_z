# encoding: utf-8
require 'minitest/autorun'
require 'jay_z'

module JayZ
  class Post < Blueprint
    default do
      author { Author.make.save }
      body { "I am a default post body" }
    end

    set(:video) do
      author { Author.make(:name => 'Anders defined in Post.video').save }
      url { 'http://www.youtube.com/watch?v=g5950v0kTJg' }
    end
  end

  class Author < Blueprint
    default do
      name { 'Anders Törnqvist' }
    end
  end
end

class Post
  extend JayZ
  attr_accessor :author
  attr_accessor :body
  attr_accessor :url
  def save; 'save in post called'; end
  def save!; self; end
end

class Author
  extend JayZ
  attr_accessor :name
  def save; self; end
end

describe JayZ do
  describe  "when extending a class with the JayZ module" do
    it "adds a .make method" do
      Post.make.must_be_instance_of(JayZ::Post)
    end

    describe ".make" do
      it "creates a blueprint proxy object" do
        Post.make.must_be_instance_of(JayZ::Post)
      end
    end

    describe "blueprint proxy object" do
      it "delegates all messages" do
        Post.make.save.must_equal 'save in post called'
      end
    end

    describe "before it delegates a message" do
      it "populates the receiver with the values from the blueprint" do
        Post.make.save!.body.must_equal 'I am a default post body'
      end
    end

    describe ".make message with a symbol argument" do
      before { @video = Post.make(:video).save! }
      it "populates the receiver with values defined in the video block" do
        @video.url.must_equal 'http://www.youtube.com/watch?v=g5950v0kTJg'
      end

      it %q{populates the receiver with values from default block if not
            defined in video block} do
        @video.body.must_equal 'I am a default post body'
      end

      describe "inside a blueprint block" do
        it "can create other objects" do
          @video.author.name.must_equal 'Anders defined in Post.video'
        end
      end
    end

  end
end
