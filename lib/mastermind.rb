require 'colorize'
require 'colorized_string'

class Game
  def start_game
    display_game_rules
    code = create_code
    guess = nil

    loop do
      while guess.class != Array do
        guess = prompt_input
      end

      @guesses_count += 1

      puts "Guess ##{@guesses_count}: " +  convert_to_colored_text(guess) + " = Hint: " + convert_hint_to_colored_text(check_guess_to_code(code, guess))

      break if @guesses_count == 13 || check_guess_to_code(code, guess) == ["O", "O", "O", "O"]

      guess = nil
    end

    if check_guess_to_code(code, guess) == ["O", "O", "O", "O"]
      puts "Congrats! You win!"
    elsif @guesses_count == 13
      puts "You weren't able to guess the code in 12 tries. ;_;"
    end

    puts "The code was #{convert_to_colored_text(code)}"
    @guesses_count = 0
  end

  def check_guess_to_code(code_arr, guess_arr)
    hints_array = []

    guess_arr.each_with_index do |element, index|
      if element == code_arr[index]
        hints_array.push("O")
      elsif code_arr.include?(element)
        hints_array.push("-")
      else
        hints_array.push("X")
      end
    end
    return hints_array.shuffle!
  end

  def prompt_input
    colors = ["R", "G", "B", "C", "M", "Y"]
    puts "Please enter four of the following letters for your guess #{red}, #{green}, #{blue}, #{cyan}, #{magenta}, or #{yellow})."
    begin
      input = gets.upcase.chomp
      input = input.split('')
    rescue
      puts "Not a valid input."
    else
      if input.length == 4 && colors.include?(input[0]) && colors.include?(input[1]) && colors.include?(input[2]) && colors.include?(input[3])
        return input
      else
        puts "Not a valid input."
      end
    end
  end

  def convert_hint_to_colored_text(array)
    color_string = ""
    array.each do |element|
      case element
      when 'O'
        color_string.concat("#{correct}")
      when '-'
        color_string.concat("#{almost_correct}")
      end
    end
    return color_string
  end

  def convert_to_colored_text (array)
    color_string = ""
    array.each_with_index do |element, index|
      case element
      when 'R'
        color_string.concat("#{red}")
      when 'G'
        color_string.concat("#{green}")
      when 'B'
        color_string.concat("#{blue}")
      when 'C'
        color_string.concat("#{cyan}")
      when 'M'
        color_string.concat("#{magenta}")
      when 'Y'
        color_string.concat("#{yellow}")
      end

      if index < (array.length - 1)
        color_string.concat (" | ")
      end
    end
    return color_string
  end

  def create_code
    code = []
    colors = ["R", "G", "B", "C", "M", "Y"]
    4.times do
      code.push(colors[rand(6)])
    end
    # puts "The secret code is #{convert_to_colored_text(code)}"
    return code
  end


  protected

  def initialize
    @guesses_count = 0
  end

  # This can probably be broken out into its own class?
  def red
    return " R ".colorize(:background => :red)
  end

  def green
    return " G ".colorize(:background => :green)
  end
  
  def blue
    return " B ".colorize(:background => :blue)
  end

  def cyan
    return " C ".colorize(:background => :cyan)
  end

  def magenta
    return " M ".colorize(:background => :magenta)
  end

  def yellow
    return " Y ".colorize(:background => :yellow)
  end

  def correct
    return " X ".colorize(:black).colorize(:background => :white)
  end

  def almost_correct
    return ColorizedString[" X "].colorize(:black).colorize(:background => :light_red)
  end

  def display_game_rules
    puts "WELCOME TO MASTERMIND!"
    puts " "
    puts "This is a game where you have 12 attempts to guess a secret code comprised of four of the following colors (and order matters):"
    puts " "
    puts "Red (#{red}), Green (#{green}), Blue (#{blue}), Cyan (#{cyan}), Magenta(#{magenta}), and Yellow (#{yellow})."
    puts " "
    puts "Of course, you will need a way to know how close your guess is to the answer. After each guess you will be shown the following markers. The position of these markers do not correlate with the positions of the guess."
    puts " "
    puts "#{correct} means that there is one correct color in the correct place"
    puts "#{almost_correct} means that there is one correct color but in the wrong place"
    puts " "
    puts "Good luck!"
    puts "**********"
  end
end