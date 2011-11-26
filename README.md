JayZ [![Stillmaintained](http://stillmaintained.com/unders/jay_z.png)](http://stillmaintained.com/unders/jay_z) [![Build Status](http://travis-ci.org/unders/jay_z.png)](http://travis-ci.org/unders/jay_z)
====


Where
-----
* [JayZ @ Github](http://github.com/unders/jay_z)
* [JayZ @ GemTesters](http://test.rubygems.org/gems/jay_z)
* [JayZ @ Rubygems](http://rubygems.org/gems/jay_z)
* [JayZ @ Rubydoc](http://rubydoc.info/gems/jay_z)

Description:
-----------

A model factory. Say no to fixtures.
Documentation is available at [rubydoc](http://rubydoc.info/gems/jay_z)

Compatibility
-------------

Ruby version 1.9.2 and 1.9.3 and Rails version 3.1

[GemTesters](http://test.rubygems.org/gems/jay_z) has
 more information on which platforms the Gem is tested.

Installation
------------

Install as a gem:

    gem install jay_z

Examples
-------

**Rails, ActiveRecord and minitest**


1.    Update Gemfile

        group :development, :test do
          gem 'jay_z', :require => 'jay_z/rails'
        end

2.    `rails generate jay_z:install`

    It adds `blueprint.rb` file to test or spec directory.

3.    Update config/application.rb

        config.generators do |g|
          g.test_framework :mini_test, :spec => true, :fixture_replacement => :jay_z
        end

4.    `rails generate model Comment post_id:integer body:text`

    It adds to the end of `(spec|test)/blueprint.rb`

        class Comment < Blueprint(ActiveRecord)
          default do
            post_id { 1 }
            body { "MyText" }
          end
        end

5.    Modify the generated blueprint according to your preferences

        class Comment < Blueprint(ActiveRecord)
	       default do
		      post { Post.make.save }
		      body { "MyText" }
	       end
        end

6.   Write tests in test/comment_test.rb

        require "minitest_helper"

        class CommentTest < MiniTest::Rails::Model
  		    before do
    	      @comment = Comment.make.new
  		    end

  		    it "must be valid" do
    	  	  @comment.valid?.must_equal true
  		    end
        end



How to test the installed Gem
-------------------------

    gem install rubygems-test
    gem test jay_z


For more info see: [GemTesters](http://test.rubygems.org/)
