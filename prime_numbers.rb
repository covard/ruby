require 'prime'

class PrimeNumbers
  def sum(number)
    puts number
    return 0 if number < 2
    (2...number).each.inject(0) { |sum, num| sum += num if PrimeNumbers.is_prime?(num) }
  end

  def self.is_prime?(number)
    return false if number < 2
    (2...number).each { |n| return false if number % n == 0 }
  end

  def self.test
    PrimeNumbers.new.sum(10) == Prime.first(10).inject(0) { |sum, num| sum += num }
  end
end
