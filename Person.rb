class Person
  
  attr_accessor :first_name, :last_name, :role
  
  def initialize(first_name, last_name, role)
    @first_name = first_name
    @last_name = last_name
    @role = role
  end
end