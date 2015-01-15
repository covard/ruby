require 'benchmark'

module Fibo
  def self.run_all(number)
    puts
    puts "*** Results ***"
    Benchmark.bm do |bm|
      bm.report("calulate_number: ") do
        calc_num = calculate_number number
        p calc_num
      end

      bm.report("number_by_recursion: ") do
        recursion_num = number_by_recursion number
        p recursion_num
      end
      puts
    end
  end

  def self.calculate_number(number)
    return number if number < 2
    (number - 1).times.inject([0, 1]) { fibo_numbers[0], fibo_numbers[1] = fibo_numbers[1], fibo_numbers[0] + fibo_numbers[1] }

    fibo_numbers[1]
  end

  def self.number_by_recursion(number)
    return number if [0, 1].include? number
    number_by_recursion(number - 1) + number_by_recursion(number - 2)
  end
end
