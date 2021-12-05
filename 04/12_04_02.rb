require './12_04_01'

include SquidBingo

def let_the_squid_win
  data = setup_data
  numbers = data[:numbers]
  boards = data[:boards]
  won_count = 0

  numbers.each_with_index do |num, num_i|
    boards.size.times do |i|
      next unless boards[i]

      matrix = Matrix.rows(boards[i])
      found = matrix.index(num)
      if found
        boards[i][found[0]][found[1]] = -1
        if check_bingo(boards[i])
          won_count += 1
          if boards.size - won_count <= 0
            puts "Last board: #{boards[i]}"
            puts "Score: #{final_score(boards[i], num)}"
            return
          else
            boards[i] = nil
          end
        end
      end
    end
  end
end

let_the_squid_win
