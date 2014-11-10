module UserCleanup
  def self.run(file_path)
    csv = SmarterCSV.process file_path, { file_encoding: 'iso-8859-1', convert_values_to_numeric: false, remove_empty_values: false, key_mapping: { middle_initial: :middle_name } }

    count = 0
    no_match_count = 0
    fixed_count = 0
    csv.each do |data|
      if data[:ssn].length == 9
        if data[:email].blank?
          people = EntityPerson.includes(:user).where(first_name: data[:first_name], last_name: data[:last_name], ssn_last_4: data[:ssn][-4, 4])
        else
          people = EntityPerson.includes(:user).where(first_name: data[:first_name], last_name: data[:last_name], ssn_last_4: data[:ssn][-4, 4], users: { email: data[:email] })
        end
        user_count = people.count

        if user_count == 1
          people.first.middle_name = data[:middle_name]
          people.first.save validate: false
          fixed_count += 1
        elsif user_count > 1
          count += 1
        elsif user_count == 0
          user = User.where("username ilike ?", "#{data[:first_name]}%#{data[:last_name]}")
          no_match_count += 1
        end
      end
    end

    puts
    puts '*** Output ***'
    puts "\tFxed: #{fixed_count}"
    puts "\tNumber of multiples found: #{count}"
    puts "\tNo matches found: #{no_match_count}"
    puts
  end

    def self.build_username(data)
    middle_initial = "#{data[:middle_name][0].gsub(/[^a-z]/i, '')}." if data[:middle_name] && !data[:middle_name].blank?
    username = "#{data[:first_name].gsub(/[^a-z]/i, '')}.#{middle_initial}#{data[:last_name].gsub(/[^a-z]/i, '')}".downcase

    username
  end
end

UserCleanup.run '/tmp/target_master_data.csv'

# =>
# *** Output ***
# 	Number of multiples found: 1
# 	No matches found: 1321



module UserCleanup
  def self.run(file_path)
    csv = SmarterCSV.process file_path, { file_encoding: 'iso-8859-1', convert_values_to_numeric: false, remove_empty_values: false, key_mapping: { middle_initial: :middle_name } }

    count = 0
    no_match_count = 0
    fixed_count = 0
    csv.each do |data|
      users = User.where username: build_username(data)
      user_count = users.length

      if user_count == 1
        p = users.first.entity.entity_person
        p.middle_name = data[:middle_name]
        p.save validate: false
        fixed_count += 1
      elsif user_count > 1
        count += 1
      elsif user_count == 0
        no_match_count += 1
      end
    end

    puts
    puts '*** Output ***'
    puts "\tFxed: #{fixed_count}"
    puts "\tNumber of multiples found: #{count}"
    puts "\tNo matches found: #{no_match_count}"
    puts
  end

  def self.build_username(data)
    middle_initial = "#{data[:middle_name][0].gsub(/[^a-z]/i, '')}." if data[:middle_name] && !data[:middle_name].blank?
    username = "#{data[:first_name].gsub(/[^a-z]/i, '')}.#{middle_initial}#{data[:last_name].gsub(/[^a-z]/i, '')}".downcase

    username
  end
end

UserCleanup.run '/tmp/target_master_data.csv'
