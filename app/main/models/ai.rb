# class Ai

#   attr_reader :moves

#   def initialize
#     @moves = []
#   end

#   def move(board)
#     possible_moves = board.possible_moves
#     last_move = board.last_move
#     corners = board.corners
#     sides = board.sides
#     move = possible_moves.sample
#     if @moves.count < 2
#       move = respond_to_side(last_move) if sides.include?(last_move)
#       move = respond_to_corner(last_move) if corners.include?(last_move)
#       move = respond_to_side_blitz(board) if (sides & possible_moves).count == 2
#       move = sides.sample if (corners & possible_moves).count == 2
#       move = respond_to_knight_blitz(board) if (sides & possible_moves).count == 3 && (corners & possible_moves).count == 3
#       move = corners.sample if last_move == "M2"
#     end
#     move = "M2" if possible_moves.include?("M2")
#     move = for_the_win(board) || board.potential_win || move
#     @moves << move
#     move
#   end

#   def respond_to_side(last_play)
#     if last_play == "T2" || last_play == "M3"
#       "B1"
#     elsif last_play == "B2" || last_play == "M1"
#       "T3"
#     end
#   end

#   def respond_to_corner(last_play)
#     if last_play == "T1"
#       "B3"
#     elsif last_play == "T3"
#       "B1"
#     elsif last_play == "B1"
#       "T3"
#     elsif last_play == "B3"
#       "T1"
#     end
#   end

#   def respond_to_side_blitz(board)
#     blitz = board.sides & board.possible_moves
#     sorted_blitz = blitz.sort
#     move = board.corners.sample
#     move = "T3" if sorted_blitz == ["B2", "M1"]
#     move = "T1" if sorted_blitz == ["B2", "M3"]
#     move = "B1" if sorted_blitz == ["M3", "T2"]
#     move = "B3" if sorted_blitz == ["M1", "T2"]
#     move
#   end

#   def respond_to_knight_blitz(board)
#     possible_moves = board.possible_moves
#     blitz = (board.corners - possible_moves) + (board.sides - possible_moves)
#     sorted_blitz = blitz.sort
#     move = "B1" if sorted_blitz == ["B3", "M1"] || sorted_blitz == ["B2", "T1"]
#     move = "T1" if sorted_blitz == ["B1", "T2"] || sorted_blitz == ["M1", "T3"]
#     move = "T3" if sorted_blitz == ["B3", "T2"] || sorted_blitz == ["M3", "T1"]
#     move = "B3" if sorted_blitz == ["B1", "M3"] || sorted_blitz == ["B2", "T3"]
#     move
#   end


#   def for_the_win(board)
#     move = nil
#     board.winning_moves.each do |p|
#       if (@moves & p).count == 2
#         possibility = p - @moves
#         move = possibility.sample
#         board.possible_moves.include?(move) ? break : move = nil
#       end
#     end
#     move
#   end
# end
