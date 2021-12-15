normal = %w(abcefg cf acdeg acdfg bcdf abdfg abdefg acf abcdefg abcdfg)
sizes = normal.map{ |s| s.size }

counts = Array.new(10, 0)
unique = [1, 4, 7, 8]

File.foreach('../inputs/12_08_01.txt') do |line|
  split = line.chomp.split(' | ')
  inputs = split[0].split(' ')
  outputs = split[1].split(' ')

  outputs.each do |output|
    found = sizes.find(output.size)
    counts[found] += 1
  end
end

n = unique.map { |i| counts[i] }.sum
p n
