# class Game

#   attr_reader :moves, :players, :human, :ai, :board
#   attr_accessor :first_player, :second_player, :turn

#   def initialize
#     @moves = []
#     @human = User.new
#     @ai = Ai.new
#     @players = [@ai, @human]
#     @board = Board.new
#     @turn = 0
#     @first_player = @players.sample
#     @second_player = (@players - [@first_player]).sample
#   end

#   def active_player
#     @turn += 1
#     player = nil
#     if @turn.odd?
#      player = @first_player
#     elsif @turn.even?
#      player = @second_player
#     end
#     player
#   end

#   def play
#     until over? || winner
#       move = ""
#       player = active_player
#       if player.class == Ai
#         puts 'My turn!'
#         move = ai.move(@board)
#       elsif player.class == Player
#         puts 'Your turn!'
#         move = gets.chomp
#       end
#       @board.add_move(move, player)
#       puts @board.display
#     end
#   end

#   def test_play
#     until over? || winner
#       move = ""
#       player = active_player
#       if player.class == Ai
#         move = ai.move(@board)
#       elsif player.class == Player
#         move = @board.possible_moves.sample
#       end
#       @board.add_move(move, player)
#     end
#   end

#   def over?
#     @board.possible_moves.empty?
#   end

#   def winner
#     @board.winning_moves.each do |w|
#       if (@ai.moves & w).sort == w.sort
#         #puts "You Lost!"
#         return @ai
#       elsif (@board.player_moves & w).sort == w.sort
#         #puts "You Won!"
#         return @human
#       end
#     end
#     return nil
#   end

# end
