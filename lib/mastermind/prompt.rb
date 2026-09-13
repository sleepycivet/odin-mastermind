require_relative 'text'

module Prompt
  include Text
  COLORS = ["R", "G", "B", "C", "M", "Y"]

  def prompt_guess
    text_prompt_guess
    player_guess = nil

    while player_guess.class != Array do
      begin
      input = gets.upcase.chomp
      input = input.split('')
      rescue
        puts "Not a valid input."
      else
        if input.length == 4 && COLORS.include?(input[0]) && COLORS.include?(input[1]) && COLORS.include?(input[2]) && COLORS.include?(input[3])
          player_guess = input
        else
          puts "Not a valid input."
        end
      end
    end
    
    return player_guess
  end

  def prompt_game_type
    text_prompt_game_type
    begin
      input = gets.upcase.chomp
      input = input.split('')
    rescue
      puts 'Please type "player" or "computer" to choose the game type.'
    else
    end
  end
end