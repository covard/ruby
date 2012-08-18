#readfile.rb
#!/usr/bin/ruby
require 'csv'

CSV.foreach("inputFile.csv") do |results|
	puts results
	puts results.length
end