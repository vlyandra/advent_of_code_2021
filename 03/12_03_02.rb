def common_bits(values, bit_index = nil)
  ones = []
  common = []
  uncommon = []
  values.each do |value|
    if bit_index
      ones[bit_index] ||= 0
      if value[bit_index] == 1
        ones[bit_index] += 1
      end
    else
      value.each_with_index do |bit, i|
        ones[i] ||= 0
        if bit == 1
          ones[i] += 1
        end
      end
    end
  end

  if bit_index
    if ones[bit_index] >= values.size/2
      common[bit_index] = 1
      uncommon[bit_index] = 0
    else
      common[bit_index] = 0
      uncommon[bit_index] = 1
    end
  else
    ones.each_with_index do |count, i|
      count ||= 0

      if count >= values.size/2
        common[i] = 1
        uncommon[i] = 0
      else
        common[i] = 0
        uncommon[i] = 1
      end
    end
  end

  return {
    common: common,
    uncommon: uncommon
  }
end

def keep_common(values, bit_index)
  common = common_bits(values, bit_index)[:common]
  keep = values.dup
  keep = keep.select! { |x| common[bit_index] == x[bit_index] }

  if keep.size <= 1 || bit_index >= values[0].size - 1
    return keep
  else
    keep_common(keep, bit_index + 1)
  end
end

def keep_uncommon(values, bit_index)
  uncommon = common_bits(values, bit_index)[:uncommon]
  keep = values.dup
  keep = keep.select! { |x| uncommon[bit_index] == x[bit_index] }

  if keep.size <= 1 || bit_index >= values[0].size - 1
    return keep
  else
    keep_uncommon(keep, bit_index + 1)
  end
end

def gas_ratings
  values = []
  File.foreach('../inputs/12_03_01.txt') do |line|
    values << line.chomp.split("").map(&:to_i)
  end

  gas_common = keep_common(values, 0)
  gas_uncommon = keep_uncommon(values, 0)
  o2 = gas_common[0].join('').to_i(2)
  co2 = gas_uncommon.join('').to_i(2)

  puts 'O2: ' + o2.to_s
  puts 'CO2: ' + co2.to_s
  puts "Life support: #{(o2 * co2).to_s}"
end

gas_ratings
