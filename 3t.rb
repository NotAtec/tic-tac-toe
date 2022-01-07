require 'pry-byebug'
class Player
  attr_reader :uname, :type
  attr_accessor :turn

  @@turn = 0
  @@players = 0
  def initialize(n)
    @uname = n
    @type = @@players.zero? ? 'X' : 'O'
    @@players += 1
  end
end

class Board
  attr_accessor :rows

  def initialize
    @rows = [["1", "2", "3"], ["4", "5", "6"], ["7", "8", "9"]]
    show
  end

  def valid?(num)
    if Board.integer?(num)
      case num.to_i
      when (1..3) then row_check(num, 0)
      when (4..6) then row_check(num, 1)
      when (7..9) then row_check(num, 2)
      end
    else
      'NAN'
    end
  end

  private

  def show
    (rows.length - 1).times do |i| 
      puts "\t\s #{rows[i].join(' | ')}"
      puts "\t ---+---+---"
    end
    puts "\t\s #{rows[2].join(' | ')}"
    puts "\n"
  end

  def row_check(num, row)
    if @rows[row].include?(num)
      true
    else
      false
    end
  end

  def self.integer?(num)
    num.to_i.to_s == num
  end
end

# Comment out for testing
#puts 'What is the name of Player 1?'
#name = gets.chomp
#one = Player.new(name)
#puts "\n"
#puts 'What is the name of Player 2?'
#name = gets.chomp
#two = Player.new(name)
#puts "\n"

one = Player.new("a")
two = Player.new("b")

board = Board.new
won = false

until won
  puts "Please input a number (0-9), that's still on the board"
  num = gets.chomp
  check = board.valid?(num)
end
