module UserNameCleanup
  def self.run(file_path)
    csv = SmarterCSV.process file_path, { file_encoding: 'iso-8859-1', convert_values_to_numeric: false, remove_empty_values: false, key_mapping: { middle_initial: :middle_name } }

    csv.each do |data|
      person = EntityPerson.where(ssn: data[:ssn])
      if person.count == 1
        person.middle_name = data[:middle_name]
        person.save validate: false
      end
    end
  end
end
