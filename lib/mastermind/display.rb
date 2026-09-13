module Display
  def display_red
    return " R ".colorize(:background => :red)
  end

  def display_green
    return " G ".colorize(:background => :green)
  end
  
  def display_blue
    return " B ".colorize(:background => :blue)
  end

  def display_cyan
    return " C ".colorize(:background => :cyan)
  end

  def display_magenta
    return " M ".colorize(:background => :magenta)
  end

  def display_yellow
    return " Y ".colorize(:background => :yellow)
  end

  def display_correct
    return " O ".colorize(:black).colorize(:background => :white)
  end

  def display_almost_correct
    return ColorizedString[" X "].colorize(:black).colorize(:background => :light_red)
  end

  def display_wrong
    return ColorizedString[" - "].colorize(:black).colorize(:background => :gray)
  end
end