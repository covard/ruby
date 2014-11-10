#!/usr/bin/ruby
class DocumentReader

  class << self
    attr_reader :reader_classes
  end
  
  @reader_classes = []
  
  def self.read(path)
    reader = reader_for(path)
    return nil unless reader
    reader.read(path)
  end
  
  def self.reader_for(path)
    show_user()
    reader_class = DocumentReader.reader_classes.find do |klass|
      klass.can_read?(path)
    end
    return reader_class.new(path) if reader_class
    nil
  end
  
  def self.inherited(subclass)
    DocumentReader.reader_classes << subclass
  end
  
  def self.show_user
    puts "Starting show_user method #{@reader_classes.length}"
    @reader_classes.each { |c| puts "\nClass #{c}" }
  end
  
end