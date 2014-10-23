module BottlesOfBeer
  def self.drink
    range = 99..0
    range.first.downto(range.last).each do |num|
      system "say #{num} bottles of beer on the wall"
      system "say #{num} bottles of beer on the wall"
      system "say take one down pass it around"
      system "say #{num - 1} bottles of beer on the wall"
    end
  end
end

BottlesOfBeer.drink
