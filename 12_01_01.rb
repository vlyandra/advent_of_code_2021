require 'csv'

input = CSV.read("inputs/12_01_01.csv").flatten

increases = 0
previous = 0

input.each_with_index do |value, i|
  unless i == 0
    if value.to_i > previous
     increases += 1
    end
  end
  previous = value.to_i
end

puts increases
