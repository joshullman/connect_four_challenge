class GameBoard
	attr_reader :board
	def initialize(params = {})
		@board_size = params[:board_size]
		@win_size = params[:win_size]
		@board = []
		@number_of_moves = 0
		@win = false
	end

	# def create_cells
	# 	row = 1
	# 	@board_size.times do
	# 		col = 1
	# 		diag_l = row
	# 		diag_r = (@board_size - row) + 1
	# 		@board_size.times do
	# 			@board << Cell.new({col: col, row: row, diag_r: diag_r, diag_l: diag_l})
	# 			col += 1
	# 			diag_l += 1
	# 			diag_r += 1
	# 		end
	# 		row += 1
	# 	end
	# end

	def create_cells
		position = 1
		column_counter = 1
		full_size = @board_size**2
		(full_size).times do
			position - @board_size > 0 ? up = position - @board_size : up = nil
			position + @board_size < full_size ? down = position + @board_size : down = nil
			position - 1 > 0 && column_counter != 1 ? left = position - 1 : left = nil
			position + 1 < full_size && column_counter != @board_size ? right = position + 1 : right = nil
			up && up - 1 > 0 && column_counter != 1 ? up_left = up - 1 : up_left = nil
			up && up + 1 > 0 && column_counter != @board_size ? up_right = up + 1 : up_right = nil
			down && down + 1 < full_size && column_counter != @board_size ? down_right = down + 1 : down_right = nil
			down && down - 1 < full_size && column_counter != 1 ? down_left = down - 1 : down_left = nil
			@board << Cell.new({
				position: position,
				col: column_counter,
				up: up, 
				down: down, 
				left: left, 
				right: right,
				up_left: up_left,
				up_right: up_right,
				down_left: down_left,
				down_right: down_right
				})
			position += 1
			column_counter += 1
			column_counter = 1 if column_counter > @board_size
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
		player_tokens = @board.find_all {|cell| cell.value == "[#{player.symbol}]"}
		until @win == true || player_tokens.empty?
			current_cell = player_tokens.pop
			check_wins(player, current_cell.left) if current_cell.left != nil
			check_wins(player, current_cell.right) if current_cell.right != nil
			check_wins(player, current_cell.up) if current_cell.up != nil
			check_wins(player, current_cell.up_left) if current_cell.up_left != nil
			check_wins(player, current_cell.up_right) if current_cell.up_right != nil
			# check_left_wins(player, current_cell)
			# check_right_wins(player, current_cell)
			# check_up_wins(player, current_cell)
			# check_up_left_wins(player, current_cell)
			# check_up_right_wins(player, current_cell)
			# check_left_wins(player, current_cell)
		end
		if @win == true
			puts "#{player.symbol} wins the game!"
		end
	end

	def check_wins(player, cell_position)
		cell_position -= 1
		@win = true if @board[cell_position].value == "[#{player.symbol}]" &&
		@board[cell_position - @board_size].value == "[#{player.symbol}]" &&
		@board[cell_position - 2*@board_size].value == "[#{player.symbol}]"
	end

	# def check_left_wins(player, cell)
	# end
	# def check_right_wins(player, cell)
	# end
	# def check_up_wins(player, cell)
	# end
	# def check_up_right_wins(player, cell)
	# 	if @board[cell.up_left - 1].value != "[#{player.symbol}]" &&
	# 	@board[cell.up_left - 1 - @board_size].value != "[#{player.symbol}]" &&
	# 	@board[cell.up_left - 1 - 2*@board_size].value != "[#{player.symbol}]" &&
	# 	@board[cell.up_left - 1 - 3*@board_size].value != "[#{player.symbol}]"
	# 		@win = true
	# 	end
	# end
	# def check_up_left_wins(player, cell)
	# 	if @board[cell.up_right - 1].value != "[#{player.symbol}]" &&
	# 	@board[cell.up_right - 1 - @board_size].value != "[#{player.symbol}]" &&
	# 	@board[cell.up_right - 1 - 2*@board_size].value != "[#{player.symbol}]" &&
	# 	@board[cell.up_right - 1 - 3*@board_size].value != "[#{player.symbol}]"
	# 		@win = true
	# 	end
	# end

	# def check_for_wins(player)
	# 	player_tokens = @board.find_all {|cell| cell.value == "[#{player.symbol}]"}
	# 	player_tokens.each do |cell|
	# 		check_row_wins(cell, player)
	# 		check_column_wins(cell, player)
	# 		check_diag_left_wins(cell, player)
	# 		check_diag_right_wins(cell, player)
	# 	end
	# 	p @win
	# 	if @win == true
	# 		puts "#{player.symbol} wins the game!"
	# 	end
	# end

	# def check_row_wins(cell, player)
	# 	row_num = cell.row
	# 	row = @board.find_all {|cell| cell.row == row_num }
	# 	i = 0
	# 	(@board_size - @win_size + 1).times do
	# 		end_point = (@win_size + i) - 1
	# 		cluster = row[i..end_point]
	# 		@win = true if cluster.all? {|cell| cell.value == "[#{player.symbol}]"}
	# 		i += 1
	# 	end
	# end

	# def check_column_wins(cell, player)
	# 	col_num = cell.col
	# 	column = @board.find_all {|cell| cell.col == col_num }
	# 	i = 0
	# 	(@board_size - @win_size + 1).times do
	# 		end_point = (@win_size + i) - 1
	# 		cluster = column[i..end_point]
	# 		@win = true if cluster.all? {|cell| cell.value == "[#{player.symbol}]"}
	# 		i += 1
	# 	end
	# end

	# def check_diag_left_wins(cell, player)
	# 	diag_l_num = cell.diag_l
	# 	diag_l = @board.find_all {|cell| cell.diag_l == diag_l_num }
	# 	i = 0
	# 	(@board_size - @win_size + 1).times do
	# 		end_point = (@win_size + i) - 1
	# 		cluster = diag_l[i..end_point]
	# 		if cluster
	# 			@win = true if cluster.all? {|cell| cell.value == "[#{player.symbol}]"} && cluster.length == @win_size
	# 		end
	# 		i += 1
	# 	end
	# end

	# def check_diag_right_wins(cell, player)
	# 	diag_r_num = cell.diag_r
	# 	diag_r = @board.find_all {|cell| cell.diag_r == diag_r_num }
	# 	i = 0
	# 	(@board_size - @win_size + 1).times do
	# 		end_point = (@win_size + i) - 1
	# 		cluster = diag_r[i..end_point]
	# 		if cluster
	# 			@win = true if cluster.all? {|cell| cell.value == "[#{player.symbol}]"} && cluster.length == @win_size
	# 		end
	# 		i += 1
	# 	end
	# end

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


# class Cell
# 	attr_reader :row, :col, :diag_r, :diag_l
# 	attr_accessor :value
# 	def initialize(params = {})
# 		@row = params[:row]
# 		@col = params[:col]
# 		@diag_r = params[:diag_r]
# 		@diag_l = params[:diag_l]
# 		@value = "[ ]"
# 	end
# end

class Player
	attr_reader :symbol
	def initialize(params = {})
		@symbol = params[:symbol]
	end
end

class Cell
	attr_reader :position, :col, :up, :down, :left, :right, 
							:up_left, :up_right, :down_left, :down_right
	attr_accessor :value
	def initialize(params = {})
		@position = params[:position]
		@col = params[:col]
		@up = params[:up]
		@down = params[:down]
		@left = params[:left]
		@right = params[:right]
		@up_left = params[:up_left]
		@up_right = params[:up_right]
		@down_left = params[:down_left]
		@down_right = params[:down_right]
		@value = "[ ]"
	end
end
# class View
# 	attr_reader :info
# 	def initialize
# 		@info = {}
# 	end

# 	def intro
# 		puts "Welcome to Connect 4!"

# 		board_size = 3
# 		while board_size.is_a? Integer
# 			puts "Please enter a board size: "
# 			board_size = gets.chomp
# 			if board_size.to_i <= 0
# 				puts "Quit trying to break me :'("
# 			end
# 		end
# 		info[:board_size] = board_size

# 		win_size = 1
# 		while win_size.to_i < board_size.to_i
# 			puts "Please enter a win streak size: "
# 			win_size = gets.chomp
# 			p win_size
# 			if win_size.to_i >= board_size.to_i
# 				puts "Quit trying to break me :'("
# 			end
# 		end
# 		info[:win_size] = win_size.to_s

# 		player_one_symbol = "A"
# 		while player_one_symbol.length == 1
# 			puts "Please enter Player One's 1 character symbol: "
# 			player_one_symbol = gets.chomp
# 			if player_one_symbol.length != 1
# 				puts "Quit trying to break me :'("
# 			end
# 		end
# 		info[:player_one_symbol] = player_one_symbol

# 		player_two_symbol = "B"
# 		while player_two_symbol.length == 1
# 			puts "Please enter Player Two's 1 character symbol: "
# 			player_two_symbol = gets.chomp
# 			if player_two_symbol.length != 1
# 				puts "Quit trying to break me :'("
# 			end
# 		end
# 		info[:player_two_symbol] = player_two_symbol

# 	end
# end

# view = View.new
# view.intro

player_one = Player.new({symbol: "J"})
player_two = Player.new({symbol: "S"})
game_board = GameBoard.new({board_size: 7, win_size: 4})
game_board.create_cells
game_board.board.each do |cell|
	p cell
	puts
end

game_board.print_board
game_board.player_move(player_one, 1)
game_board.print_board
game_board.player_move(player_one, 1)
game_board.print_board
game_board.player_move(player_one, 1)
game_board.print_board
game_board.player_move(player_one, 1)
game_board.print_board

