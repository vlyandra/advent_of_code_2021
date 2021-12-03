require 'csv'

input = CSV.read("inputs/12_01_01.csv").flatten

increases = 0
previous = 0

input.each_cons(3) do |values|
  current = values.sum {|x| x.to_i }
  unless previous == 0
    if current > previous
      increases += 1
    end
  end

  previous = current
end
puts increases
