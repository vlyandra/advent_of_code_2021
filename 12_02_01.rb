horizontal = 0
vertical = 0
File.foreach('inputs/12_02_01.txt') do |line|
  puts line
  ary = line.split(' ')
  cmd = ary[0]
  num = ary[1].to_i

  if cmd == 'forward'
    horizontal += num
  elsif cmd == 'down'
    vertical += num
  elsif cmd == 'up'
    vertical -= num
  end
end

puts horizontal
puts vertical
puts horizontal * vertical
