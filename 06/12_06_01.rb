fish = Array.new(9, 0)

data_str = File.read('../inputs/12_06_01.txt')

data_ary = data_str.chomp.split(",")

data_ary.map(&:to_i).each do |timer|
  fish[timer] += 1
end

256.times do
  prev = fish.dup

  8.downto(0) do |day|
    if day == 0
      fish[8] = prev[0]
      fish[6] += prev[0]
    else
      fish[day-1] = prev[day]
    end
  end
end

puts fish.sum
