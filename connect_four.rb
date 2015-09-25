class Board
	attr_reader :board
	def initialize(params = {})
		@board_size = params[:board_size]
		@win_size = params[:win_size]
		@board = []
		@number_of_moves = 0
		@win = false
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

	def player_move(player, col)
		last_cell = @board.find_all {|cell| cell.col == col && cell.value == "[ ]"}.last
		last_cell.value = "[#{player.symbol}]"
		check_for_wins(player)
	end

	def check_for_wins(player)
		@board.each do |cell|
			check_row_wins(cell, player)
			check_column_wins(cell, player)
			check_diag_left_wins(cell, player)
			check_diag_right_wins(cell, player)
		end
		p @win
		if @win == true
			puts "#{player.symbol} wins the game!"
		end
	end

	def check_row_wins(cell, player)
		row_num = cell.row
		row = @board.find_all {|cell| cell.row == row_num }
		i = 0
		(@board_size - @win_size + 1).times do
			end_point = (@win_size + i) - 1
			cluster = row[i..end_point]
			@win = true if cluster.all? {|cell| cell.value == "[#{player.symbol}]"}
			i += 1
		end
	end

	def check_column_wins(cell, player)
		col_num = cell.col
		column = @board.find_all {|cell| cell.col == col_num }
		i = 0
		(@board_size - @win_size + 1).times do
			end_point = (@win_size + i) - 1
			cluster = column[i..end_point]
			@win = true if cluster.all? {|cell| cell.value == "[#{player.symbol}]"}
			i += 1
		end
	end

	def check_diag_left_wins(cell, player)
		diag_l_num = cell.diag_l
		diag_l = @board.find_all {|cell| cell.diag_l == diag_l_num }
		i = 0
		(@board_size - @win_size + 1).times do
			end_point = (@win_size + i) - 1
			cluster = diag_l[i..end_point]
			if cluster
				@win = true if cluster.all? {|cell| cell.value == "[#{player.symbol}]"} && cluster.length == @win_size
			end
			i += 1
		end
	end

	def check_diag_right_wins(cell, player)
		diag_r_num = cell.diag_r
		diag_r = @board.find_all {|cell| cell.diag_r == diag_r_num }
		i = 0
		(@board_size - @win_size + 1).times do
			end_point = (@win_size + i) - 1
			cluster = diag_r[i..end_point]
			if cluster
				@win = true if cluster.all? {|cell| cell.value == "[#{player.symbol}]"} && cluster.length == @win_size
			end
			i += 1
		end
	end

	def print_board
		num = 1
		@board_size.times do 
			print "  #{num}  "
			num += 1
		end
		puts
		@board.each_slice(@board_size).each do |row|
			row.each do |cell|
				print " #{cell.value} "
			end
			puts
		end
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
	attr_reader :symbol
	def initialize(params = {})
		@symbol = params[:symbol]
	end
end

player_one = Player.new({symbol: "J"})
player_two = Player.new({symbol: "S"})
game_board = Board.new({board_size: 7, win_size: 4})
game_board.create_cells
game_board.board.each do |row|
	p row
	puts
end

game_board.player_move(player_one, 1)
game_board.print_board
game_board.player_move(player_one, 1)
game_board.print_board
game_board.player_move(player_one, 1)
game_board.print_board
game_board.player_move(player_one, 1)
game_board.print_board

