def rename_file path, new_name_part
  unless path.empty?
    files = Dir.entries(path)

    files.each do |f|
      next if f == "." || f == ".."
      old_name = path + "\\" + f
      new_name = path + "\\" + f.split("_")[0] + "_" + new_name_part + File.extname(f)
      
      puts "Old Name"
      puts old_name
      puts
      puts "New Name"
      puts new_name
      puts
      #File.rename(old_name, new_name)
    end
  end
end

rename_file ARGV[0], ARGV[1]
