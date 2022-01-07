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
      if num.to_i.positive? && num.to_i < 10
        case num.to_i
        when (1..3) then row_check(num, 0)
        when (4..6) then row_check(num, 1)
        when (7..9) then row_check(num, 2)
        end
      else
        'ERRNUM'
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

  def input
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
  num = player.input
  check = PlayLoop.valid(num)
  case check
  when false then puts "#{player.name}, Please input a number (1-9), that's still available!"
  when 'NAN' then puts "#{player.name}, Please input a number between 1 & 9!"
  when 'ERRNUM' then puts "#{player.name}, Please input a number between 1 & 9, and nothing more or less."
  else player.update_board(num, check) end
end

def check_winners
  row0 = Board.rows[0]
  row1 = Board.rows[1]
  row2 = Board.rows[2]

  if row0.uniq.length == 1
    true
  elsif row1.uniq.length == 1
    true
  elsif row2.uniq.length == 1
    true
  elsif [row0[0], row1[0], row2[0]].uniq.length == 1
    true
  elsif [row0[1], row1[1], row2[1]].uniq.length == 1
    true
  elsif [row0[2], row1[2], row2[2]].uniq.length == 1
    true
  elsif [row0[0], row1[1], row2[2]].uniq.length == 1
    true
  elsif [row0[2], row1[1], row2[0]].uniq.length == 1
    true
  end
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
    won = check_winners
  end
  Player.played = false
end
