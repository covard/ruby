# script to just process some data, coming from a csv file and displaying the email
# if it's not missing that is. not that that would ever happen ;-)

module DisplayEmail
  def self.process(store_number, email_hash)
    email_hash.each do |key, val|
      puts
      puts key
      puts "\t#{val}"
      puts "\t#{val.downcase}" unless val.blank?
    end
  end
end
