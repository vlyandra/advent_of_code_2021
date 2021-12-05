ones = []
input_count = 0
common = []
uncommon = []

File.foreach('../inputs/12_03_01.txt') do |line|
  bits = line.split('')
  bits.each_with_index do |bit, i|
    if bit.to_i == 1
      ones[i] ||= 0
      ones[i] += 1
    end
  end
  input_count += 1
end

ones.each_with_index do |count, i|
  if count >= input_count/2
    common[i] = 1
    uncommon[i] = 0
  else
    common[i] = 0
    uncommon[i] = 1
  end
end

gamma = common.join('').to_s.to_i(2)
epsilon = uncommon.join('').to_s.to_i(2)

puts "Gamma: #{gamma}"
puts "Epsilon: #{epsilon}"
puts gamma * epsilon
