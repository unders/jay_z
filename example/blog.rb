# encoding: utf-8
$LOAD_PATH << File.dirname(__FILE__) + "../../lib"
require 'jay_z'

module JayZ
  class Post < Blueprint
    default do
      author { Author.make.save }
      body { "I am a default post body" }
    end

    define(:video) do
      author { Author.make(:name => 'Anders defined in video').save }
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

puts "\nPost.make \n"
p Post.make # => <JayZ::Post:0x007ffb9b838c10
            #     @object=#<Post:0x007ffb9b8389b8
            #     @author=#<Author:0x007ffb9b8386e8
            #     @name="Anders Törnqvist">,
            #     @body="I am a default post body">>

puts "\nPost.make(:video) \n"
p Post.make(:video) # => <JayZ::Post:0x007fd329837f80
                    #    @object=#<Post:0x007fd329837dc8
                    #    @author=#<Author:0x007fd329837ad0
                    #    @name="Anders defined in video">,
                    #    @body="I am a default post body",
                    #    @url="http://www.youtube.com/watch?v=g5950v0kTJg">>


puts "\npost = Post.make.save! \n"
post = Post.make.save!
p post.author # => <Author:0x007fc70a838d70 @name="Anders Törnqvist">
p post.body # => "I am a default post body"
p post.url # => nil

puts "\npost = Post.make(:video).save! \n"
post = Post.make(:video).save!
p post.author # => <Author:0x007ff669037db8 @name="Anders defined in video">
p post.body # => "I am a default post body"
p post.url # => "http://www.youtube.com/watch?v=g5950v0kTJg"
