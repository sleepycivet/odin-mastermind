require_relative './colorize'

module Text
  include Colorize

  def text_prompt_input
    puts "Please enter four of the following letters for your guess #{colorize_red}, #{colorize_green}, #{colorize_blue}, #{colorize_cyan}, #{colorize_magenta}, or #{colorize_yellow})."
  end

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
    puts " "
    puts "Good luck!"
    puts "**********"
  end
end