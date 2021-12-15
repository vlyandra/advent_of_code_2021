data_str = File.read('../inputs/12_07_01.txt')

data_ary = data_str.chomp.split(",").map(&:to_i)

costs = (data_ary.min..data_ary.max).map do |n|
  try = data_ary.map do |a|
    diff = (n-a).abs
    ((diff + 1) * diff) / 2
  end
  try.sum
end


fuel = costs.min


p fuel
