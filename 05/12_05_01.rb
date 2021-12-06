require 'set'

class Coordinates
  attr_reader :start, :finish

  def initialize(line)
    coordinates = line.chomp.split(' -> ')

    @start = coordinates[0].split(',').map(&:to_i)
    @finish = coordinates[1].split(',').map(&:to_i)
  end

  def straight?
    horizontal? || vertical?
  end

  def vertical?
    @start[0] == @finish[0]
  end

  def horizontal?
    @start[1] == @finish[1]
  end
end

found = Set.new
overlap = Set.new

File.foreach('../inputs/12_05_01.txt').with_index do |line, i|
  coords = Coordinates.new(line) if !line.empty?

  if coords.vertical?
    range = [coords.start[1], coords.finish[1]].sort
    Range.new(*range).each do |value|
      point = [coords.start[0], value]
      unless found.add?(point)
        overlap.add(point)
      end
    end
  elsif coords.horizontal?
    range = [coords.start[0], coords.finish[0]].sort
    Range.new(*range).each do |value|
      point = [value, coords.start[1]]
      unless found.add?(point)
        overlap.add(point)
      end
    end
  else
    length = (coords.start[0] - coords.finish[0]).abs + 1

    x_increment = (coords.start[0] - coords.finish[0]) > 0 ? -1 : 1
    y_increment = (coords.start[1] - coords.finish[1]) > 0 ? -1 : 1
    x = coords.start[0]
    y = coords.start[1]

    length.times do
      point = [x, y]

      unless found.add?(point)
        overlap.add(point)
      end

      x += x_increment
      y += y_increment
    end
  end
end

puts overlap.size
