class Board
  attr_accessor :one, :two, :board, :filler

  def initialize(one, two, *filler) #one and two are names, X/0 colors/symbols and filler is an optional different table filler
    @one = Player.new(one, "X")
    @two = Player.new(two, "O")


    @board = Array.new(3) {Array.new(3){Cell.new(filler)}}
  end

  class Player
    attr_accessor :name, :color #change to reader if possible

    def initialize(name, color)
      @name = name
      @color = color #add only X/0 later
    end
  end

  class Cell
    attr_accessor :symbol #basic symbol, make it empty when generating board later #change later to reader unless needed
    def initialize(symbol="")
      @symbol = symbol
    end
  end

  def print_board
    @board.each do |row|
      puts row.map { |cell| cell.symbol.empty? ? "_": cell.symbol }.join(" ")
      #if it was called value, it would be cell.value
    end
  end

  def pick_cell(row, col)
    @board[row][col]
  end

  def set_cell(row, col, color)
    pick_cell(row, col).symbol = color
  end

  def check_full(row, col)
    raise ArgumentError if pick_cell(row, col).symbol == @two.color || pick_cell(row, col).symbol == @one.color
  end

  def switch_players
    @one, @two = @two, @one
  end

  def next_move
    puts "#{one.name}, it's your turn with color #{one.color}. Enter a number from 1-9!"
  end

  def get_move(move = gets.chomp)
    move_to_coor(move)
  end

  def move_to_coor(move)
    mapping = {
    "1" => [0, 0],
    "2" => [0, 1],
    "3" => [0, 2],
    "4" => [1, 0],
    "5" => [1, 1],
    "6" => [1, 2],
    "7" => [2, 0],
    "8" => [2, 1],
    "9" => [2, 2]
    }
    mapping[move]
  end

  def play
    puts "START"
    while true
      print_board
      puts next_move

      begin
        row, col = get_move
        check_full(row, col)
      rescue
        puts "The position is full or the input is not valid, please try again!"
        retry
      end
      set_cell(row, col, @one.color)
      # unless pick_cell(row, col).symbol == @two.color
      switch_players
    end
  end

end

board  = Board.new("Gligor", "Biljana")

board.play
