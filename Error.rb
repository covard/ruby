class Error
  attr_accessor :message, :error_number
  
  def initialize(message, error_number)
    @message = message
    @error_number = error_number
  end
  
end