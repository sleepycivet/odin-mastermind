module Colorize
  def colorize_red
    return " R ".colorize(:background => :red)
  end

  def colorize_green
    return " G ".colorize(:background => :green)
  end
  
  def colorize_blue
    return " B ".colorize(:background => :blue)
  end

  def colorize_cyan
    return " C ".colorize(:background => :cyan)
  end

  def colorize_magenta
    return " M ".colorize(:background => :magenta)
  end

  def colorize_yellow
    return " Y ".colorize(:background => :yellow)
  end

  def colorize_correct
    return " O ".colorize(:black).colorize(:background => :white)
  end

  def colorize_almost_correct
    return ColorizedString[" X "].colorize(:black).colorize(:background => :light_red)
  end

  def colorize_wrong
    return ColorizedString[" - "].colorize(:black).colorize(:background => :gray)
  end
end