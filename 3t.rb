require 'pry-byebug'

class Board
  @@rows = [%w[1 2 3], %w[4 5 6], %w[7 8 9]]

  def self.rows
    @@rows
  end
end

class PlayLoop

end

class Player
  attr_reader :name, :char

  def initialize(name, char)
    @name = name
    @char = char
  end

  def get_input
    puts "#{@name}, Please input a number (0-9), that's still on the board."
    gets.chomp
end

def turn(player)
  num = player.get_input

end

won = false
turn = 0

until won
  if turn == 0
    turn(one)

  else

end
