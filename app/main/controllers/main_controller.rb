# By default Volt generates this controller for your Main component
module Main
  class MainController < Volt::ModelController

    model :page

    def index
        
    end

    def add_ai_move(possible_moves, last_play)
      corners = ["T1", "T3", "B1", "B3"]
      sides = ["T2", "B2", "M1", "M3"]
      move = possible_moves.sample
      if (page._ai_moves.to_a).count < 2
        move = respond_to_side(last_play) if sides.include?(last_play)
        move = respond_to_corner(last_play) if corners.include?(last_play)
        move = respond_to_side_blitz(possible_moves, sides, corners) if (sides & possible_moves).count == 2
        move = sides.sample if (corners & possible_moves).count == 2
        move = respond_to_knight_blitz(possible_moves, sides, corners) if (sides & possible_moves).count == 3 && (corners & possible_moves).count == 3
        move = corners.sample if last_play == "M2"
      end
      move = "M2" if possible_moves.include?("M2")
      move = for_the_win(possible_moves) || potential_win(possible_moves) || move
      page._ai_moves << move
      page._moves << move
    end

     def respond_to_side(last_play)
    if last_play == "T2" || last_play == "M3"
      "B1"
    elsif last_play == "B2" || last_play == "M1"
      "T3"
    end
  end

  def respond_to_corner(last_play)
    if last_play == "T1"
      "B3"
    elsif last_play == "T3"
      "B1"
    elsif last_play == "B1"
      "T3"
    elsif last_play == "B3"
      "T1"
    end
  end

  def respond_to_side_blitz(possible_moves, sides, corners)
    blitz = sides & possible_moves
    sorted_blitz = blitz.sort
    move = corners.sample
    move = "T3" if sorted_blitz == ["B2", "M1"]
    move = "T1" if sorted_blitz == ["B2", "M3"]
    move = "B1" if sorted_blitz == ["M3", "T2"]
    move = "B3" if sorted_blitz == ["M1", "T2"]
    move
  end

  def respond_to_knight_blitz(possible_moves, sides, corners)
    blitz = (board.corners - possible_moves) + (board.sides - possible_moves)
    sorted_blitz = blitz.sort
    move = "B1" if sorted_blitz == ["B3", "M1"] || sorted_blitz == ["B2", "T1"]
    move = "T1" if sorted_blitz == ["B1", "T2"] || sorted_blitz == ["M1", "T3"]
    move = "T3" if sorted_blitz == ["B3", "T2"] || sorted_blitz == ["M3", "T1"]
    move = "B3" if sorted_blitz == ["B1", "M3"] || sorted_blitz == ["B2", "T3"]
    move
  end

  def potential_win(possible_moves)
    winning_moves = [["T1", "T2", "T3"], ["B1", "B2", "B3"], ["M1", "M2", "M3"],
                        ["T1", "M1", "B1"], ["T2", "M2", "B2"], ["T3", "M3", "B3"],
                        ["T1", "M2", "B3"], ["T3", "M2", "B1"]]
    move = nil
    winning_moves.each do |p|
      if (page._player_moves.to_a & p).count == 2
        possibility = p - _player_moves.to_a
        move = possibility.first
        possible_moves.include?(move) ? break : move = nil
      end
    end
    move
  end

  def for_the_win(possible_moves)
    move = nil
    winning_moves = [["T1", "T2", "T3"], ["B1", "B2", "B3"], ["M1", "M2", "M3"],
                     ["T1", "M1", "B1"], ["T2", "M2", "B2"], ["T3", "M3", "B3"],
                     ["T1", "M2", "B3"], ["T3", "M2", "B1"]]
    winning_moves.each do |p|
      if (_ai_moves.to_a & p).count == 2
        possibility = p - _ai_moves.to_a
        move = possibility.sample
        possible_moves.include?(move) ? break : move = nil
      end
    end
    move
  end
    def add_move(move)
      total_moves = ["T1", "T2", "T3", "M1", "M2", "M3", "B1", "B2", "B3"]
      page._moves << move
      page._player_moves << move
      possible_moves = ["T1", "T2", "T3", "M1", "M2", "M3", "B1", "B2", "B3"] - _moves.to_a
      add_ai_move(possible_moves, move)
      page._move = ''
    end
  def winner
    winning_moves = [["T1", "T2", "T3"], ["B1", "B2", "B3"], ["M1", "M2", "M3"],
                     ["T1", "M1", "B1"], ["T2", "M2", "B2"], ["T3", "M3", "B3"],
                     ["T1", "M2", "B3"], ["T3", "M2", "B1"]]

    winning_moves.each do |w|
      if (_ai_moves.to_a & w).sort == w.sort
        #puts "You Lost!"
        return "AI"
      elsif (_player_moves.to_a & w).sort == w.sort
        #puts "You Won!"
        return "Human"
      end
    end
    return nil
  end

  def over?
      possible_moves = ["T1", "T2", "T3", "M1", "M2", "M3", "B1", "B2", "B3"] - _moves.to_a
   possibilities = possible_moves - _moves.to_a
   possibilities.empty?
  end

  def clear_moves
    _moves.clear
    _ai_moves.clear
    _player_moves.clear
  end
    private

    # The main template contains a #template binding that shows another
    # template.  This is the path to that template.  It may change based
    # on the params._component, params._controller, and params._action values.
    def main_path
      "#{params._component || 'main'}/#{params._controller || 'main'}/#{params._action || 'index'}"
    end

    # Determine if the current nav component is the active one by looking
    # at the first part of the url against the href attribute.
    def active_tab?
      url.path.split('/')[1] == attrs.href.split('/')[1]
    end
  end
end
