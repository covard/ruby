File.open('./test.txt') do |f|
  	until f.eof?
    	puts f.readline
    end
end