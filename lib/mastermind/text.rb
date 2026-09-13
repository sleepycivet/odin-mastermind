require_relative './display'

module Text
  include Display

  def text_prompt_input
    puts "Please enter four of the following letters for your guess #{display_red}, #{display_green}, #{display_blue}, #{display_cyan}, #{display_magenta}, or #{display_yellow})."
  end

  def text_game_rules
    puts "WELCOME TO MASTERMIND!"
    puts " "
    puts "This is a game where you have 12 attempts to guess a secret code comprised of four of the following colors (and order matters):"
    puts " "
    puts "Red (#{display_red}), Green (#{display_green}), Blue (#{display_blue}), Cyan (#{display_cyan}), Magenta(#{display_magenta}), and Yellow (#{display_yellow})."
    puts " "
    puts "Of course, you will need a way to know how close your guess is to the answer. After each guess you will be shown the following markers. The position of these markers do not correlate with the positions of the guess."
    puts " "
    puts "#{display_correct} means that there is one correct color in the correct place"
    puts "#{display_almost_correct} means that there is one correct color but in the wrong place"
    puts " "
    puts "Good luck!"
    puts "**********"
  end
end