require './Person.rb'
require 'spreadsheet'
require 'logger'
class ReadExcel
  def parse_file(file_path)
    if /.xls$/ =~ file_path
      sheet = init_file(file_path)
            
      sheet.each do |row|
        column_array = row.to_ary
        if (column_array[0] != "Fname")
          person = Person.new(column_array[0], column_array[1], column_array[2])
          puts "Person: #{person.first_name} #{person.last_name} #{person.role}"
        end
      end
     else
      log("Wrong input type. Should be '.xls' ->" + file_path)
    end 
  end
  
  def log(msg)
    logger = Logger.new('c://rubylog/ReadExcel.log', 'daily')
    logger.info{msg}
    logger.close
  end
  
  def init_file(file_path)
    begin
      log("Attempt to open file.")
      book = Spreadsheet.open(file_path)
      log("File opened")
      
      book.worksheet("Sheet1")
    rescue Exception => e
      log("There was an error!!!!!!!!" + e.message)
      puts "Error: " + e.message
    end
  end
end
