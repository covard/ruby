require 'benchmark'

module Fibo
  def self.run_all(number)
    puts
    puts "*** Results ***"
    Benchmark.bm do |bm|
      bm.report("calculate_nth_fib_number: ") do
        calc_num = calculate_nth_fib_number number.to_i
        p calc_num
      end

      bm.report("nth_fib_number_by_recursion: ") do
        recursion_num = nth_fib_number_by_recursion number.to_i
        p recursion_num
      end
      puts
    end
  end

  def self.calculate_nth_fib_number(number)
    return number if number < 2
    fibo_numbers = [0, 1]
    # figure why fibo_numbers gets lost when using inject
    (number - 1).times { fibo_numbers[0], fibo_numbers[1] = fibo_numbers[1], fibo_numbers[0] + fibo_numbers[1] }

    fibo_numbers[1]
  end

  def self.nth_fib_number_by_recursion(number)
    return number if [0, 1].include? number
    nth_fib_number_by_recursion(number - 1) + nth_fib_number_by_recursion(number - 2)
  end
end

Fibo.run_all ARGV[0]
