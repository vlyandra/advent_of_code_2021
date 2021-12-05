require 'matrix'

module SquidBingo
  extend self

  def check_bingo(board)
    matrix = Matrix.rows(board)
    # DIAGONALS DON'T COUNT I NEED TO LEARN TO READ

    matrix.column_vectors.each do |column|
      if column.to_a.all?(-1)
        return true
      end
    end

    matrix.row_vectors.each do |row|
      if row.to_a.all?(-1)
        return true
      end
    end

    false
  end

  # To reflect across y = x, used to swap the matrix diagonals
  # And it turns out diagonals don't count, so this was unnecessarily complicated
  # Cool, cool, go me
  # def reflection_matrix(dimension)
  #   rows = []
  #   dimension.times do |n|
  #     row = Array.new(dimension, 0)
  #     row[-(n+1)] = 1
  #     rows << row
  #   end
  #
  #   return Matrix.rows(rows)
  # end

  def final_score(board, called)
    sum = 0

    board.each do |row|
      sum += row.sum { |x| x < 0 ? 0 : x }
    end

    sum * called
  end

  def setup_data
    numbers = []
    boards = []
    current_board = []
    dimension = 0

    File.foreach('../inputs/12_04_01.txt').with_index do |line, i|
      line = line.chomp
      if i == 0
        numbers = line.split(',').map(&:to_i)
      elsif line.empty?
        if current_board.any?
          dimension ||= current_board[0].size
          boards << current_board
          current_board = []
        end
      else
        current_board << line.split(' ').map(&:to_i)
      end
    end

    return {
      numbers: numbers,
      boards: boards
    }
  end

  def play
    data = setup_data
    numbers = data[:numbers]
    boards = data[:boards]

    numbers.each_with_index do |num, num_i|
      boards.each_with_index do |board, i|
        matrix = Matrix.rows(board)
        found = matrix.index(num)
        if found
          boards[i][found[0]][found[1]] = -1
          if check_bingo(boards[i])
            puts "Winning board was ##{i + 1}"
            puts "Matched: #{boards[i].to_s}"
            puts "Called #{num_i} numbers: #{numbers[0..num_i].to_s}"
            puts "Score: #{final_score(boards[i], num)}"
            return
          end
        end
      end
    end
  end
end
