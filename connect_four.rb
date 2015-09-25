class GameBoard
	attr_reader :board
	def initialize(params = {})
		@board_size = params[:board_size]
		@win_size = params[:win_size]
		@board = []
		@number_of_moves = 0
		@win = false
	end

	def create_cells
		position = 1
		column_counter = 1
		full_size = @board_size**2
		(full_size).times do
			position - @board_size > 0 ? up = position - @board_size : up = nil
			position - 1 > 0 && column_counter != 1 ? left = position - 1 : left = nil
			position + 1 < full_size && column_counter != @board_size ? right = position + 1 : right = nil
			up && up - 1 > 0 && column_counter != 1 ? up_left = up - 1 : up_left = nil
			up && up + 1 > 0 && column_counter != @board_size ? up_right = up + 1 : up_right = nil
			@board << Cell.new({
				position: position,
				col: column_counter,
				up: up, 
				left: left, 
				right: right,
				up_left: up_left,
				up_right: up_right
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
			check_connected_cells(player, current_cell.left) if current_cell.left != nil
			check_connected_cells(player, current_cell.right) if current_cell.right != nil
			check_connected_cells(player, current_cell.up) if current_cell.up != nil
			check_connected_cells(player, current_cell.up_left) if current_cell.up_left != nil
			check_connected_cells(player, current_cell.up_right) if current_cell.up_right != nil
		end
		if @win == true
			puts "#{player.symbol} wins the game!"
		end
	end

	def check_connected_cells(player, cell_position)
		cell_position -= 1
		multiplier = 0
		counter = 1
		(@win_size - 1).times do 
			counter += 1 if @board[cell_position - @board_size * multiplier].value == "[#{player.symbol}]"
			multiplier += 1
		end
		@win = true if counter == @win_size
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
	attr_reader :position, :col, :up, :left, :right, 
							:up_left, :up_right
	attr_accessor :value
	def initialize(params = {})
		@position = params[:position]
		@col = params[:col]
		@up = params[:up]
		@left = params[:left]
		@right = params[:right]
		@up_left = params[:up_left]
		@up_right = params[:up_right]
		@value = "[ ]"
	end
end

class Player
	attr_reader :symbol
	def initialize(params = {})
		@symbol = params[:symbol]
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

game_board.print_board
game_board.player_move(player_one, 1)
game_board.print_board
game_board.player_move(player_one, 1)
game_board.print_board
game_board.player_move(player_one, 1)
game_board.print_board
game_board.player_move(player_one, 1)
game_board.print_board

