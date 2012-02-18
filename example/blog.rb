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

puts "The proxy objects must be defined in a module named JayZ."
puts %q{The name of the classes defined in the JayZ namespace must have the
same name as its corresponding classes.}
puts %q{Each class must have one default block. The deafult block will populate
a new object when e.g Post.make method is called.}
puts
puts %q{module JayZ
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
end}
puts
puts "\n'extend JayZ' adds one method: .make to the class that it is extended to."
puts "When e.g. 'Post.make' is called, it returns the JayZ proxy object."
puts
puts %q{class Post
  extend JayZ
  attr_accessor :author
  attr_accessor :body
  attr_accessor :url
  def save; 'save in post called'; end
  def save!; self; end
end}
puts
puts %q{class Author
  extend JayZ
  attr_accessor :name
  def save; self; end
end}


puts "\nPost.make"
p Post.make # => <JayZ::Post:0x007ffb9b838c10
            #     @object=#<Post:0x007ffb9b8389b8
            #     @author=#<Author:0x007ffb9b8386e8
            #     @name="Anders Törnqvist">,
            #     @body="I am a default post body">>

puts "\nPost.make(:video)"
p Post.make(:video) # => <JayZ::Post:0x007fd329837f80
                    #    @object=#<Post:0x007fd329837dc8
                    #    @author=#<Author:0x007fd329837ad0
                    #    @name="Anders defined in video">,
                    #    @body="I am a default post body",
                    #    @url="http://www.youtube.com/watch?v=g5950v0kTJg">>


puts "\npost = Post.make.save! \n"
post = Post.make.save!

# <Author:0x007fc70a838d70 @name="Anders Törnqvist">
puts "post.author: #{post.author.inspect}"
puts "post.body: #{post.body}" # => "I am a default post body"
puts "post.url: #{post.url}" # => nil

puts "\npost = Post.make(:video).save! \n"
post = Post.make(:video).save!

# <Author:0x007ff669037db8 @name="Anders defined in video">
puts "post.author #{post.author.inspect}"
puts "post.body  #{post.body}" # => "I am a default post body"
puts "post.url #{post.url}" # => "http://www.youtube.com/watch?v=g5950v0kTJg"
