class Board
	attr_reader :board
	def initialize(board_size, win_size)
		@board_size = board_size
		@win_size = win_size
		@board = []
	end

	def create_cells
		y_position = 1
		@board_size.times do
			x_position = "A"
			row = []
			@board_size.times do
				row << Cell.new(x_position, y_position)
				x_position = x_position.next
			end
			@board << row
			y_position += 1
		end
	end
end

class Cell
	attr_accessor :x_position, :y_position
	def initialize(x_position, y_position)
		@x_position = x_position
		@y_position = y_position
	end
end

board = Board.new(7, 4)
board.create_cells
board.board.each do |row|
	p row
	puts
end

