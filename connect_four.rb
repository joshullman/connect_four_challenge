class Board
	attr_reader :board
	def initialize(params = {})
		@board_size = params[:board_size]
		@win_size = params[:win_size]
		@board = []
		@number_of_moves = 0
	end

	def create_cells
		y_position = 1
		@board_size.times do
			x_position = "A"
			row = []
			@board_size.times do
				row << Cell.new({x_position: x_position, y_position: y_position})
				x_position = x_position.next
			end
			@board << row
			y_position += 1
		end
		create_column_reference
	end

	def create_column_reference
		@column_reference = {}
		y = "A"
		y_num = 1
		@board_size.times do 
			@column_reference[y] = y_num
			y = y.next
			y_num += 1
		end
	end

	def determine_first_move
		coin_toss = rand(2)
	end

	def player_move(y_cord, player)

	end

	def check_for_wins
		@win = false
		flipped_board = @board.reverse
		p flipped_board
		flipped_board.each do |cell|
			check_horiz_wins(cell)
			if !flipped_board[@board_size - @win_size].all? {|cell| cell.value. == "[ ]" }
				check_vert_wins(cell)
				check_diag_left_wins(cell)
				check_diag_right_wins(cell)
			end
		end
		if @win == true
		else
		end
	end

	def determine_column(cell)
		@column_reference[cell.y_position]
	end

	def check_horiz_wins(cell)
		counter = 0
		
		@board[determine_column(cell) - 1]
		@win = true if counter == @win_size
	end

	def check_vert_wins(cell)
		counter = 0
		@win = true if counter == @win_size
	end

	def check_diag_left_wins(cell)
		counter = 0
		@win = true if counter == @win_size
	end

	def check_diag_right_wins(cell)
		counter = 0
		@win = true if counter == @win_size
	end
end

class Cell
	attr_accessor :value
	def initialize(params = {})
		@x_position = params[:x_position]
		@y_position = params[:y_position]
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

# player_one = Player.new({name: , symbol: })
# player_two = Player.new({name: , symbol: })
board = Board.new({board_size: 7, win_size: 4})
board.create_cells
# board.board.each do |row|
# 	p row
# 	puts
# end

p board.check_for_wins

