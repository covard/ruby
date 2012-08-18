#some_array = (5..10)

#puts some_array.inject{ |sum, n| sum + n }
##require './ReadExcel.rb'
require './PadRows.rb'
#require './ImportPerson.rb'

PadRows.process_file("C://TestFilesRuby//R9896 Summary Reports 06.22.12.xls")

#import = ImportPerson.new
#import.start_import 'c://test.csv'

#read_excel = ReadExcel.new  
#read_excel.parse_file('c://TestFile.xls')

