module UserCleanup
  def self.run(file_path)
    csv = SmarterCSV.process file_path, { file_encoding: 'iso-8859-1', convert_values_to_numeric: false, remove_empty_values: false, key_mapping: { middle_initial: :middle_name } }

    count = 0
    people = []
    csv.each do |data|
      person = EntityPerson.where(first_name: data[:first_name], last_name: data[:last_name], ssn_last_4: data[:ssn][-4, 4])

      if person.count == 1
        person.first.middle_name = data[:middle_name]
        person.first.save validate: false
      else
        count += 1
        people = person.inject([]) { |arry, p| arry << [p.first_name, p.last_name, p.ssn, p.ssn_last_4] }
      end
    end
    write_to_file people
    puts
    puts '*** Output ***'
    puts "\tNumber of multiples found: #{count}"
    puts
  end

  def self.write_to_file(data)
    CSV.open('/tmp/cleanup_output.csv', 'w') do |csv|
      csv << ['first_name','last_name','ssn','last_4']
      data.each do |d|
        csv << d
      end
    end
  end
end
