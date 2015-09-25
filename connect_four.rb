class Board
	attr_reader :board
	def initialize(params = {})
		@board_size = params[:board_size]
		@win_size = params[:win_size]
		@board = []
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
	end

	def determine_first_move
		coin_toss = rand(2)
	end

	def player_move(position, player)

	end

	def check_for_wins
		@win = false
	end

	def check_horiz_wins(cell)
		counter = 0
	end

	def check_vert_wins(cell)
		counter = 0
	end

	def check_diag_left_wins(cell)
		counter = 0
	end

	def check_diag_right_wins(cell)
		counter = 0
	end
end

class Cell
	attr_accessor :x_position, :y_position, :value
	def initialize(params = {})
		@x_position = params[:x_position]
		@y_position = params[:y_position]
		@value = []
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
board.board.each do |row|
	p row
	puts
end

