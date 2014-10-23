require 'smarter_csv'

module CreateSeed
  def self.process_file(file_path, output_file_path, class_name)
    csv = SmarterCSV.process file_path, { convert_values_to_numeric: false, remove_empty_values: false }
    @seed_file = File.open output_file_path, 'w'
    csv.each do |data|
      output_data data, class_name
    end
    @seed_file.close
  end

  def self.output_data(data, class_name)
    @seed_file.write "#{class_name}.find_or_create_by(#{data})\r\n"
  end
end

if ARGV.length == 3
  CreateSeed.process_file ARGV[0], ARGV[1], ARGV[2]
else
  puts
  puts "\tSorry but you need to add arguments: arg_1: input file path, arg_2: output file path, arg_3: ClassName."
  puts "\tPlease try again."
  puts "\tbtw happy rubying =~)"
  puts
end
