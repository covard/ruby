class FirstClass
  attr_accessor :first, :last
  
  def self.CheckLogic
    silver_plan = false
    chrome_plan = false
    dsnp = false
  
    if (!silver_plan && !chrome_plan && !dsnp)
      puts "\nThis text is for all plans except silver, not chrome and not dsnp"
    end
  end
  
  def PrintInfo
    puts "\nFirst name: #{@first}\nLast name: #{self.last}"
  end
end
 
FirstClass.CheckLogic()

fc = FirstClass.new
fc.first=("Curtis")
fc.last=("Ovard")
fc.PrintInfo