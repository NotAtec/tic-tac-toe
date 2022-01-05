require 'pry-byebug'
class Player
  attr_reader :uname, :type

  @@players = 0
  def initialize(n)
    @uname = n
    @type = @@players ? 'X' : 'O'
    @@players += 1
  end
end

# Comment out for testing
puts 'What is the name of Player 1?'
name = gets.chomp
player = Player.new(name)

puts 'What is the name of Player 2?'
name = gets.chomp
player_two = Player.new(name)


