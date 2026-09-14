require_relative './colorize'

module Text
  include Colorize

  def text_game_rules
    puts "WELCOME TO MASTERMIND!"
    puts " "
    puts "This is a game where you have 12 attempts to guess a secret code comprised of four of the following colors (and order matters):"
    puts " "
    puts "Red (#{colorize_red}), Green (#{colorize_green}), Blue (#{colorize_blue}), Cyan (#{colorize_cyan}), Magenta(#{colorize_magenta}), and Yellow (#{colorize_yellow})."
    puts " "
    puts "Of course, you will need a way to know how close your guess is to the answer. After each guess you will be shown the following markers. The position of these markers do not correlate with the positions of the guess."
    puts " "
    puts "#{colorize_correct} means that there is one correct color in the correct place"
    puts "#{colorize_almost_correct} means that there is one correct color but in the wrong place"
    puts "#{colorize_wrong} means that there is one with the wrong color."
    puts "**********"
  end

  def text_prompt_guess
    puts "Please enter four of the following letters for your guess #{colorize_red}, #{colorize_green}, #{colorize_blue}, #{colorize_cyan}, #{colorize_magenta}, or #{colorize_yellow})."
  end

  def text_prompt_game_type
    puts 'What type of game would you like to play?'
    puts 'Type "player" if you would like to choose the code and the computer will guess.'
    puts 'Type "computer" if you would like the computer to choose the code and you will guess.'
  end

  def text_player_guess_game
    puts "You chose to guess the code selected by the computer."
  end

  def text_computer_guess_game
    puts "You choose the code and the computer will guess it."
  end

  def text_prompt_code
    puts "Please enter four of the following letters to create a code for the computer to guess: #{colorize_red}, #{colorize_green}, #{colorize_blue}, #{colorize_cyan}, #{colorize_magenta}, or #{colorize_yellow})."
  end

  def text_player_code
    return "The code you chose is: "
  end
end