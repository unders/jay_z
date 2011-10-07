JayZ [![Stillmaintained](http://stillmaintained.com/unders/jay_z.png)](http://stillmaintained.com/unders/jay_z)
====

* http://github.com/unders/jay_z
* [![Build Status](http://travis-ci.org/unders/jay_z.png)](http://travis-ci.org/unders/jay_z)
* [GemTesters](http://test.rubygems.org/gems/jay_z)

Description:
-----------

A model factory. Say no to fixtures.
Documentation is available at [rubydoc](http://rubydoc.info/gems/jay_z)

Compatibility
-------------

Ruby version 1.9.2 and Rails version 3.1

[GemTesters](http://test.rubygems.org/gems/jay_z) has
 more information on which platform the Gem is tested.

Install
-------

Install as a gem:

    gem install jay_z

Rails and ActiveRecord
----------------------

1. `rails g jay_z:install`
It adds `bluprint.rb` file to test or spec directory.

2. Update these files
**Gemfile**

    group :development, :test do
      gem 'jay_z', :require => 'jay_z/active_record'
    end

**config/application.rb**

    config.generators do |g|
      g.test_framework :mini_test, :spec => true, :fixture_replacement => :jay_z
    end

3. `g generate model Comment post_id:integer body:text`
It adds to the end of `(spec|test)/blueprint.rb`

    class Comment < Blueprint(ActiveRecord)
      default do
        post { Post.make.save }
        body { "MyText" }
      end
    end

How to test the installed Gem
-------------------------

    gem install rubygems-test
    gem test jay_z


For more info see: [GemTesters](http://test.rubygems.org/)
