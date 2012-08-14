require 'logger'
class LogMessage
  def self.log(msg, file_path, duration)
    begin
      logger = Logger.new(file_path, duration)
      logger.info{msg}
    ensure
      logger.close
    end
  end
end
