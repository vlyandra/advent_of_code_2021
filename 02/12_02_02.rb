horizontal = 0
depth = 0
aim = 0
File.foreach('../inputs/12_02_01.txt') do |line|
  puts line
  ary = line.split(' ')
  cmd = ary[0]
  num = ary[1].to_i

  if cmd == 'forward'
    horizontal += num
    depth += aim * num
  elsif cmd == 'down'
    aim += num
  elsif cmd == 'up'
    aim -= num
  end
end

puts horizontal
puts depth
puts aim
puts horizontal * depth
