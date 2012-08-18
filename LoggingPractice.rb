require 'logger'
class FunWithLogging
  
  def self.do_some_logging
    logger = Logger.new("c://rubylog/log.log", 'daily')
    logger.info(:init) { "Init the app..... and..... go......"}
    logger.info(:info) {"Thanks for letting me know that was helpful."}
    logger.close
  end
  
end


FunWithLogging.do_some_logging
