JayZ is [![Stillmaintained](http://stillmaintained.com/images/abandoned.png)](http://stillmaintained.com/unders/jay_z) and renamed to: [Letterpress](https://github.com/unders/letterpress)
====


# Abandoned
* [Letterpress](https://github.com/unders/letterpress)


Examples
-------

**Rails, ActiveRecord and minitest**


1. Update Gemfile

        group :development, :test do
          gem 'jay_z', :require => 'jay_z/rails'
        end

2. Install the gem

        $ bundle install

3. Generate (test|spec)/blueprint.rb file

        $ rails generate jay_z:install

4. Update config/application.rb

        config.generators do |g|
          g.test_framework :mini_test, :spec => true, :fixture_replacement => :jay_z
        end

5. Generate a model object with its factory

        $ rails generate model Comment post_id:integer body:text

6. It adds to the end of file (test|spec)/blueprint.rb

        class Comment < Blueprint(ProxyMethods)
          default do
            post_id { 1 }
            body { "MyText" }
          end
        end

7. Modify the generated blueprint according to your preferences

        class Comment < Blueprint(ProxyMethods)
          default do
            post { Post.make.save }
            body { "MyText" }
          end
        end

8. Write tests in test/comment_test.rb

        require "minitest_helper"

        class CommentTest < MiniTest::Rails::Model
          before do
            @comment = Comment.make.new
          end

          it "must be valid" do
            @comment.valid?.must_equal true
          end
        end

