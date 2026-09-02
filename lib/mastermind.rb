require 'colorize'
require 'colorized_string'

class Game
  def start_game
    puts "WELCOME TO MASTERMIND!"
    puts " "
    puts "This is a game where you guess a secret code comprised of four of the following colors (and order matters):"
    puts " "
    puts "Red (#{red}), Green (#{green}), Blue (#{blue})), Cyan (#{cyan}), Magenta(#{magenta}), and Yellow (#{yellow})."
    puts " "
    puts "Of course, you will need a way to know how close your guess is to the answer. After each guess you will be shown the following markers. The position of these markers do not correlate with the positions of the guess."
    puts " "
    puts "#{correct} means that there is one correct color in the correct place"
    puts "#{almost_correct} means that there is one correct color but in the wrong place"
  end


  protected
  @COLORS = ["R", "G", "B", "C", "M", "Y"]

  def red
    return "R".colorize(:background => :red)
  end

  def green
    return "G".colorize(:background => :green)
  end
  
  def blue
    return "B".colorize(:background => :blue)
  end

  def cyan
    return "C".colorize(:background => :cyan)
  end

  def magenta
    return "M".colorize(:background => :magenta)
  end

  def yellow
    return "Y".colorize(:background => :yellow)
  end

  def correct
    return "X".colorize(:black).colorize(:background => :white)
  end

  def almost_correct
    return "X".colorize(:red).colorize(:background => :white)
  end
end


# Colors: R, G, B, C, M, Y

# Guess 01: R | _ | _ | _