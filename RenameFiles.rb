def rename_file path, new_name_part, old_name_part
  unless path.empty?
    files = Dir.entries(path)

    puts "Are you sure you want to rename " + files.count.to_s + " files? (yes or no)"
    rename_files = gets.chomp

    if rename_files.downcase == "yes"
      files.each do |f|
        next if f == "." || f == ".."
        old_name = path + "/" + f
        new_name = path + "/" + f.gsub(old_name_part, new_name_part)

        File.rename(old_name, new_name)
      end
    else
      puts "Renaming cancled"
    end
    puts
    puts "Rename Completed"
    puts
    system "ls -l " + path
  end
end

puts "Enter directory: "
path = gets.chomp


if File.directory? path
  puts "Enter text to replace: "
  old_name_part = gets.chomp

  puts "Enter replacement text: "
  new_name_part = gets.chomp

  rename_file path, new_name_part, old_name_part
else
  puts "That path does not exist"
end
