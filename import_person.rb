require 'csv'
require './Person.rb'
#require 'mysql'
require 'dbi'
require './LogMessage.rb'
class ImportPerson
  $log_file = './log/ImportPersonLog.txt'
  $log_duration = :daily
  $data_base = Mysql.init
  
  def start_import(file_path)
    if /.csv$/ =~ file_path
      reader = init_file(file_path)
      process_file(reader)
      close_db
    else
      LogMessage.log("The is not of the proper type should be .csv, (file: )")
    end
  end
  
  def init_file(file_path)
    begin
      CSV.open(file_path)
    rescue Exception => e
      LogMessage.log(e.message, $log_file, $log_duration)
    end
  end
  
  def process_file(reader)
    connect_db
    if data_base
      header_row = reader.shift
      reader.each do |row|
        person = Person.new(row[0], row[1], row[2])
        insert_into_db(person)
      end
    end
  end
  
  def connect_db
    begin
      $data_base.real_connect('localhost', 'testuser', 'testpass', 'test')
    rescue Mysql::Error => e
      msg = "MySQL Error-\n Error Number: #{e.errno}\n Error Message: #{e.error}"
      puts 'MySql Error'
    end
  end
  
  def close_db(db)
    db.close if db
  end
  
  def insert_into_db(person)
    insert_statement = "insert into Person (FName, LName, Role) values ('#{person.first_name}', '#{person.last_name}', '#{person.role}')"
    
    begin
      $data_base.query(insert_statement)
    rescue Mysql::Error => e
      msg = "MySQL Error-\n Error Number: #{e.errorno}\n Error Message: #{e.error}"
      LogMessage.log(e.message, $log_file, $log_duration)
    end
  end
end
