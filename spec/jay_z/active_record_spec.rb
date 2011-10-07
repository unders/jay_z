# encoding: utf-8

require 'rails/railtie'
require 'active_record'
require 'jay_z/active_record'
require 'minitest/autorun'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3",
                                        :database => ":memory:")

ActiveRecord::Schema.define do
  create_table :posts do |t|
    t.string :title
    t.text :body
    t.integer :author_id
  end
  create_table :authors do |t|
    t.string :name
  end
end

class Post < ActiveRecord::Base
  belongs_to :author
  validates_presence_of :title
  validates_presence_of :author_id
  validates_uniqueness_of :title
end

class Author < ActiveRecord::Base
  validates_presence_of :name
end

# blueprint.rb
module JayZ
  class Author < Blueprint(ActiveRecord)
    default do
      name { "Anders" }
    end
  end

  class Post < Blueprint(ActiveRecord)
    default do
      title  { "Post #{sn}" }
      body   { "Lorem ipsum..." }
      author { Author.make.save }
    end
  end
end

describe ActiveRecord do
  describe ".make" do
    it "returns a proxy object" do
      Post.make.must_be_instance_of(JayZ::Post)
    end
  end

  describe "#new" do
    describe "a valid object" do
      before { @post = Post.make.new }
      it "returns a populated record" do
        @post.must_be_instance_of(Post)
        @post.body.must_equal "Lorem ipsum..."
      end

      it "does not persist the record" do
        Post.count.must_equal 0
      end
    end

    describe "an invalid object" do
      it "raises an exception" do
        lambda {
          Post.make(:author => nil).new
        }.must_raise(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "#new!" do
    describe "a valid object" do
      before { @post2 = Post.make.new! }
      it "returns a populated record" do
        @post2.must_be_instance_of(Post)
        @post2.body.must_equal "Lorem ipsum..."
      end

      it "does not persist the record" do
        Post.count.must_equal 0
      end
    end

    describe "an invalid object" do
      it "returns a populated object" do
        Post.make(:author => nil).new!.body.must_equal "Lorem ipsum..."
      end
    end
  end

  describe "#save" do
    before { @post3 = Post.make.save }

    describe "a valid object" do
      it "persists and returns a populated record" do
        @post3.must_be_instance_of(Post)
        @post3.body.must_equal "Lorem ipsum..."
        Post.count.must_equal 1
      end
    end

    describe "an invalid object" do
      it "raises an exception" do
        lambda {
          Post.make(:author => nil).save
        }.must_raise(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe 'makes fields uniq with #{sn}' do
    before do
      user = Author.make.save
      @post1 = Post.make(:author => user).save
      @post2 = Post.make(:author => user).save
      @post3 = Post.make(:author => user).save
      @post4 = Post.make(:author => user).save
    end

    it "creates object that has uniq fields" do
      @post1.valid?.must_equal true
      @post2.valid?.must_equal true
      @post3.valid?.must_equal true
      @post4.valid?.must_equal true
      Post.count.must_equal 4
    end

    after do
      Post.delete_all
    end

  end
end
