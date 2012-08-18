require './DocumentReader'
class PlainTextReader < DocumentReader

  @title = ''
  @author = ''
  @content = ''

  def self.can_read?(path)
    /.*\.txt/ =~ path
  end
  
  def initialize(path)
    @path = path
  end
  
  def read(path)
    File.open(path) do |f|
      @title = f.readline.chomp
      @author = f.readline.chomp
      @content = f.read.chomp
    end
    self.replace_crap_content()  
    self.fucking_print_output()
  end
  
  def fucking_print_output
    puts "Here is the text:\nTitle:#{@title}\nAuthor:#{@author}\nContent:#{@content}"
  end
  
  def replace_crap_content
    @content = "Your crap content was replaced. Try again." if  /bunch of text/ =~ @content
  end
  
end