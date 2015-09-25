class Board
	attr_reader :board
	def initialize(params = {})
		@board_size = params[:board_size]
		@win_size = params[:win_size]
		@board = []
		@number_of_moves = 0
	end

	def create_cells
		row = 1
		@board_size.times do
			col = 1
			diag_l = row
			diag_r = (@board_size - row) + 1
			@board_size.times do
				@board << Cell.new({col: col, row: row, diag_r: diag_r, diag_l: diag_l})
				col += 1
				diag_l += 1
				diag_r += 1
			end
			row += 1
		end
	end

	def determine_first_move
		coin_toss = rand(2)
	end

	def player_move(y_cord, player)

	end

	def check_for_wins(player)
		@win = false
		@board.each do |cell|
			check_horiz_wins(cell, player)
			check_vert_wins(cell, player)
			check_diag_left_wins(cell, player)
			check_diag_right_wins(cell, player)
		end
		if @win == true
			puts "#{player.name} + wins the game!"
		end
	end

	def check_row_wins(cell, player)
		row_num = cell.row
		row = @board.find_all {|cell| cell.row == row_num }
		i = 0
		(@board_size - @win_size).times do
			end_point = (@win_size + i) - 1
			@win = true if row[i..end_point].all? {|cell| cell.value == player.symbol}
		end
	end

	def check_column_wins(cell, player)
		col_num = cell.col
		column = @board.find_all {|cell| cell.col == col_num }
		i = 0
		(@board_size - @win_size).times do
			end_point = (@win_size + i) - 1
			@win = true if column[i..end_point].all? {|cell| cell.value == player.symbol}
		end
	end

	def check_diag_left_wins(cell, player)
		counter = 0
		@win = true if counter == @win_size
	end

	def check_diag_right_wins(cell, player)
		counter = 0
		@win = true if counter == @win_size
	end
end


class Cell
	attr_reader :row, :col, :diag_r, :diag_l
	attr_accessor :value
	def initialize(params = {})
		@row = params[:row]
		@col = params[:col]
		@diag_r = params[:diag_r]
		@diag_l = params[:diag_l]
		@value = "[ ]"
	end
end

class Player
	attr_reader :name, :symbol
	def initialize(params = {})
		@name = params[:name]
		@symbol = params[:symbol]
	end
end

player_one = Player.new({name: "Jimmy", symbol: "J"})
player_two = Player.new({name: "Susan", symbol: "S"})
board = Board.new({board_size: 7, win_size: 4})
board.create_cells
board.board.each do |row|
	p row
	puts
end

p board.check_for_wins(player_one)

