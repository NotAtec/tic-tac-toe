require 'pry-byebug'

class Board
  @@rows = [%w[1 2 3], %w[4 5 6], %w[7 8 9]]

  def self.rows
    @@rows
  end

  def self.show
    (@@rows.length - 1).times do |i|
      puts "\t\s #{rows[i].join(' | ')}"
      puts "\t ---+---+---"
    end
    puts "\t\s #{rows[2].join(' | ')}"
    puts "\n"
  end

end

class PlayLoop
  def self.valid(num)
    if integer?(num)
      case num.to_i
      when (1..3) then row_check(num, 0)
      when (4..6) then row_check(num, 1)
      when (7..9) then row_check(num, 2)
      end
    else
      'NAN'
    end
  end

  class << self
    private

    def row_check(num, row)
      if Board.rows[row].include?(num)
        row
      else
        false
      end
    end

    def integer?(num)
      num.to_i.to_s == num
    end
  end
end

class Player
  attr_reader :name, :char
  
  @@played = false
  def initialize(name, char)
    @name = name
    @char = char
  end

  def get_input
    puts "#{@name}, Please input a number (1-9), that's still on the board."
    gets.chomp
  end

  def update_board(num, row)
    Board.rows[row][Board.rows[row].index(num)] = @char
    @@played = true
  end

  def self.played
    @@played
  end

  def self.played=(new)
    @@played = new
  end
end

def play(player)
  Board.show
  num = player.get_input
  check = PlayLoop.valid(num)
  case check
  when false then puts "#{player.name}, Please input a number (1-9), that's still available!"
  when "NAN" then puts "#{player.name}, Please input a number between 1 & 9!"
  else player.update_board(num, check) end
end

# Testing only, get player names before prod
one = Player.new("a", "X")
two = Player.new("b", "O")
# /Testing

won = false
turn = 0

until won
  turn.zero? ? play(one) : play(two)
  if Player.played
    turn.zero? ? turn += 1 : turn = 0
  end
  Player.played = false
end
