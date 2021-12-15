data_str = File.read('../inputs/12_07_01.txt')

data_ary = data_str.chomp.split(",").map(&:to_i)

fuel = (data_ary.min..data_ary.max).map do |n|
  data_ary.map do |a|
    (n-a).abs
  end.sum
end.min


p fuel
