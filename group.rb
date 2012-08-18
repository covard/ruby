#group.rb
#!/usr/bin/ruby

def print_array
  puts 'Start print_array'
  
  movies = { title:'Star Wars', genre:'sci fi', rating:10 } 
  movies.each { |name, value| puts "#{name} => #{value}" }
end

def average_word_length(words)
  puts "\nRunning average_word_length"
  total = words.inject(0.0) { |result, word| word.size + result }
  puts 'Average word length is: ' + (total / words.size).to_s
end

print_array()
words = %w{This is a bunch of words in a ruby array }
average_word_length(words)