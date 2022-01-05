require 'pry-byebug'
class Player
  attr_reader :uname, :type
  attr_accessor :turn

  @@turn = 0
  @@players = 0
  def initialize(n)
    @uname = n
    @type = @@players ? 'X' : 'O'
    @@players += 1
  end
end

class Board
  attr_reader :rows

  def initialize
    @rows = [["1 ", "2", "3"], ["4 ", "5", "6"], ["7 ", "8", "9"]]
  end

  def play(num)
    if Board.is_integer?(num)
      case num
      when (1..3)
        if @rows[0].include?(num)
          process(num)
        else
          available
        end
      when (4..6)
        if @rows[1].include?(num)
          process(num)
        else
          available
        end
      when (7..9)
        if @rows[2].include?(num)
          process(num)
        else
          available
        end
      end
    else
      puts "Please input a number between 0 & 9"
    end
  end

  private

  def show
    (rows.length - 1).times do |i| 
      puts "\t #{rows[i].join(' | ')}"
      puts "\t ---+---+---"
    end
    puts "\t #{rows[2].join(' | ')}"
    puts "\n"
  end

  def self.is_integer?(num)
    num.to_i.to_s == num
  end

  def process(num)
    Player.turn.zero? ? @rows[rows.index(num)] = one.type : @rows[rows.index(num)] = two.type
    Player.turn.zero? ? Player.turn += 1 : Player.turn = 0
  end

  def available()
    puts "Please input a number (0-9) That's still available on the board"
  end
end

# Comment out for testing
puts 'What is the name of Player 1?'
name = gets.chomp
one = Player.new(name)
puts "\n"
puts 'What is the name of Player 2?'
name = gets.chomp
two = Player.new(name)
puts "\n"

board = Board.new


num = gets.chomp
board.play(num)
