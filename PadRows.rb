require 'rubygems'
require 'spreadsheet'
require 'logger'
require './Error.rb'
class PadRows
  $error = Error.new(nil, nil)
  $file_path = nil
  $new_book = nil
  $orig_book = nil
  $lorum_ipsum = lorem_ipsum = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  $four_column = [$lorum_ipsum,$lorum_ipsum,$lorum_ipsum,$lorum_ipsum]
  $six_column = [$lorum_ipsum,$lorum_ipsum,$lorum_ipsum,$lorum_ipsum,$lorum_ipsum,$lorum_ipsum]
  
  def self.process_file(path)
    $file_path = path
    $orig_book = init_file()
    $new_book = create_new_file()
    
    loop_sheets
    path_contents = path.split("//")
    save_file($new_book, "C://TestFilesRuby//Padded_#{path_contents[2]}")
    $orig_book.close
    $new_book.close
  end
  
  def self.loop_sheets
    sheet_index = 0
    
    $orig_book.worksheets.each do |sheet|
      $new_book.create_worksheet :name => sheet.name
      insert_headers(sheet, sheet_index)
      add_padding_rows($new_book.worksheet(sheet_index), sheet)
      add_data($new_book.worksheet(sheet_index), sheet)
      sheet_index += 1
    end
  end
  
  def self.init_file()
    begin
      log("Attempt to open file.")
      if /.xls$/ =~ $file_path
        Spreadsheet.open($file_path)
      #elsif  /.xls$/ =~ $file_path
        #Excel.new($file_path)
      else
        log("Wrong file type. Input file must be either .xls.")
      end
    rescue Exception => e
      log("There was an error!!!!!!!!" + e.message)
      puts "Error: " + e.message
    end
  end
  
  def self.create_new_file
    $new_book = Spreadsheet::Workbook.new
  end
  
  def self.add_padding(sheet)
    for i in 1..8
      sheet.insert_row(5, $four_column)
    end
  end
  
  def self.add_padding_rows(new_book_sheet, orig_book_sheet)
    column_index = 0
    begin
      for i in 1..8
        column_index = 0
        orig_book_sheet.row(0).each do |column|
          new_book_sheet.row(i).insert(column_index, $lorum_ipsum)  
          column_index += 1
        end
      end
    rescue Exception => e
      log("Error: #{e.message}")
      puts "Error adding data"
    end
  end
  
  def self.insert_headers(sheet, sheet_index)
    index = 0
    sheet.row(0).each do |column|
      $new_book.worksheet(sheet_index)[0, index] = column
      index += 1
    end
  end
  
  def self.add_data(new_book_sheet, old_book_sheet)
    row_index = 9
    header_row = 0
    old_book_sheet.each do |row|
      if header_row > 0
        column_index = 0
        row.each do |column|
          new_book_sheet.row(row_index).insert(column_index, column)
          column_index += 1
        end
        row_index += 1
      end
      header_row = 1
    end
  end
  
  def self.save_file(book, path)
    book.write(path)
  end
  
  def self.log(msg)
    logger = Logger.new('c://rubylog/ReadExcel.log', 'daily')
    logger.info{msg}
    logger.close
  end
  
end